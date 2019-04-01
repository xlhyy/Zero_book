# openpyxl


- 知识点

```
# encoding: utf-8

import openpyxl


wb1 = openpyxl.load_workbook('hello.xlsx')

print "====================Workbook对象======================"

'''
Workbook对象部分属性:
    worksheets      :以列表形式返回所有的worksheet
    encoding        :获取文档的字符集编码
    properties      :获取文档的元数据，如标题，创建者，创建日期等
'''
print wb1.worksheets
print wb1.encoding
print wb1.properties.title
print wb1.properties.created


'''
Workbook对象部分方法:
    get_sheet_names()   :获取所有表格的名称
    get_sheet_by_name() :通过表名获取Worksheet对象
'''
wbs = wb1.get_sheet_names()
print wbs
ws1 = wb1.get_sheet_by_name(wbs[0])
print ws1

print "====================Worksheet对象======================"

'''
Worksheet对象部分属性:
    title       :表格的标题
    rows        :按行获取单元格(Cell对象) - 生成器
    columns     :按列获取单元格(Cell对象) - 生成器
'''
print ws1.title
# print ws1.rows
# print ws1.columns


'''
Worksheet对象部分方法:
    cell        :获取单元格对象
'''
wc1 = ws1.cell(row=1, column=2)

print "====================Cell对象======================"

'''
Cell对象部分属性:
    row         :单元格所在的行
    column      :单元格所在的列
    value       :单元格的值
'''
print wc1.row
print wc1.column
print wc1.value
```


- 项目实例

```
# encoding: utf-8

import itertools, openpyxl, datetime, re, json

def resolve_xls(file_name):
    """解析xls文件
    :param file_name:
    :return:
    """
    xl = openpyxl.load_workbook(filename=file_name, use_iterators=True)
    result = {}
    for sheet in xl.worksheets:
        sheet_title = sheet.title.strip()
        keys = []
        rows_data = []
        iter_r = sheet.iter_rows()
        for i, row in enumerate(iter_r):
            if i == 0:
                keys = resolve_hander(row)
            else:
                row_data = resolve_row(keys, row)
                if row_data:
                    rows_data.append(row_data)
                else:
                    break
        sorted_rows_data = sorted(rows_data, key=lambda x: x['server_id'])
        result[sheet_title] = sorted_rows_data
    return result

def resolve_hander(row):
    # (RawCell(row=2, column='A', coordinate='A2', internal_value=u'g931', data_type='s', style_id='4', number_format='general'), RawCell(row=2, column='B', coordinate='B2', internal_value=u'2018-11-04', data_type='s', style_id='5', number_format='@'), RawCell(row=2, column='C', coordinate='C2', internal_value=u'2018-11-11 00:01', data_type='s', style_id='6', number_format='@'))
    # (RawCell(row=3, column='A', coordinate='A3', internal_value=u'g930', data_type='s', style_id='4', number_format='general'), RawCell(row=3, column='B', coordinate='B3', internal_value=u'2018-11-02', data_type='s', style_id='5', number_format='@'), RawCell(row=3, column='C', coordinate='C3', internal_value=u'2018-11-09 00:01', data_type='s', style_id='6', number_format='@'))

    keys = []
    for i in row:
        keys.append(i.internal_value)
    return keys
    # [u'server_id', u'\u5f00\u670d\u65f6\u95f4', u'shift_time']

def resolve_row(keys, row):
    if not row[0].internal_value and row[0].internal_value != 0:
        return {}
    data = {}
    for k, v in itertools.izip(keys, row):
        if v.internal_value:
            data[k] = v.internal_value
    return data
    # {u'server_id': u'g931', u'\u5f00\u670d\u65f6\u95f4': u'2018-11-04', u'shift_time': u'2018-11-11 00:01'}
    # {u'server_id': u'g930', u'\u5f00\u670d\u65f6\u95f4': u'2018-11-02', u'shift_time': u'2018-11-09 00:01'}

# ------------------------------------------------------------------

def generate_python(data):
    """生成python需要的数据
    :param data:
    :return:
    """
    result = {}
    for gplatform, value in data.iteritems():
        if gplatform not in result:
            result[gplatform] = {}
        for row in value:
            server = row['server_id'].strip()
            shift_time = row['shift_time'].strip()
            shift_time_str = datetime.datetime.strptime(shift_time, '%Y-%m-%d %H:%M').strftime('%Y-%m-%d %H:%M')
            if shift_time_str not in result[gplatform]:
                result[gplatform][shift_time_str] = {server: 2}
            else:
                result[gplatform][shift_time_str][server] = 2
        return result
        # {'pub': {'2018-11-11 00:01': {u'g931': 2}, '2018-11-09 00:01': {u'g930': 2}}}


# ------------------------------------------------------------------

def generate_nginx(data, firsts):
    """生成nginx需要的数据
    :param data:
    :param firsts: {'pub': 'g27[0-0]'}
    :return:
    """
    sorted_r = {}
    for gplatform, value in data.iteritems():
        r = {}
        for row in value:
            server = row['server_id'].strip()
            shift_time = row['shift_time'].strip()
            if shift_time not in r:
                r[shift_time] = [server]
            else:
                r[shift_time].append(server)
        sorted_rows_data = sorted(r.iteritems(), key=lambda x: x[0])
        sorted_r[gplatform] = sorted_rows_data

    result = {}
    nginx_format = 'mapping_%s=($(repeat "%s") $(repeat "%s"))'
    # print sorted_r
    # {'pub': [(u'2018-11-09 00:01', [u'g930']), (u'2018-11-11 00:01', [u'g931'])]}

    for gplatform, value in sorted_r.iteritems():
        if gplatform not in result:
            result[gplatform] = []
        first = firsts[gplatform]
        for shift_time, servers in value:
            time_str = datetime.datetime.strptime(shift_time, '%Y-%m-%d %H:%M').strftime('%Y-%m-%d')
            re_data = resolve_re(first)
            # print re_data
            # print "=="
            # ['/', 'g', 92, '[', 0, '-', 9, ']', '/']
            # ==
            # ['/', 'g', 93, '[', 0, '-', 0, ']', '/']
            # ==

            end = resolve_re_data(re_data, len(servers))
            # print end
            # print "=="
            # /g92[0-9]/|/g93[0-0]/
            # ==
            # /g93[0-1]/
            # ==

            nginx_data = nginx_format % (time_str, first, end)
            for server in servers:
                if not re.compile(end).match('/%s/' % server):
                    raise Exception
            first = end[end.rfind('|')+1:]
            result[gplatform].append(nginx_data)
    
    # print result
    # {'pub': ['mapping_2018-11-09=($(repeat "/g92[0-9]/") $(repeat "/g92[0-9]/|/g93[0-0]/"))', 'mapping_2018-11-11=($(repeat "/g93[0-0]/") $(repeat "/g93[0-1]/"))']}
    return result

def resolve_re(re_formate):
    data = []
    temp = ''
    for i in re_formate:
        if i in ['/', '[', ']', '-', '|']:
            if temp:
                data.append(int(temp))
                temp = ''
            data.append(i)
        elif not i.isdigit():
            if temp:
                data.append(int(temp))
                temp = ''
            data.append(i)
        else:
            temp = temp + i
    return data

def resolve_re_data(data, num=1):
    print data
    print "=="
    # ['/', 'g', 92, '[', 0, '-', 9, ']', '/']
    # =
    # ['/', 'g', 93, '[', 0, '-', 0, ']', '/']
    # =

    for i in xrange(num):
        count = data.count('|')
        print count
        if data[-3] < 9:
            data[-3] += 1
        else:
            new_data = list(data)
            new_data[-7] += 1 + count
            new_data[-3] = 0
            new_data[-5] = 0
            new_data.insert(0, '|')
            data.extend(new_data)
    return ''.join(map(str, data))

# ------------------------------------------------------------------

def main(file_name):
    xls_data = resolve_xls(file_name)

    print "----------python----------"
    python_data = generate_python(xls_data)
    for pf, servers in python_data.iteritems():
        print '==========%s==========' % pf
        print json.dumps(servers, indent=4)

    print "----------nginx-----------"
    nginx_data = generate_nginx(xls_data, {'pub': '/g92[0-9]/'})
    for pf, mappings in nginx_data.iteritems():
        print '==========%s==========' % pf
        for mapping in mappings:
            print mapping

if __name__ == "__main__":
    main("hello.xlsx")
```
