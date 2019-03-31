# -*- coding: utf-8 –*-

import os
import sys
import openpyxl
import re


""" #####################    转换模板    #####################"""

space = ['', None, 0.0, 0, ' ', '  ']

int_compile = re.compile('^-?\d+$').match
float_compile = re.compile('^-?\d+\.\d*$').match


def is_int(value):
    """ 字符串是否为整数包括负数

    :param value:
    :return:
    """
    if int_compile(value):
        return True
    else:
        return False


def is_float(value):
    """ 字符串是否为浮点数

    :param value:
    :return:
    """
    if float_compile(value):
        return True
    else:
        return False


def force_str(text, encoding="utf-8", errors='strict'):
    """ 转换成string
    """
    t_type = type(text)
    if t_type == str:
        return text
    elif t_type == unicode:
        return text.encode(encoding, errors)
    return str(text)


def force_unicode(text, encoding="utf-8", errors='strict'):
    """ 转换成 unicode
    """
    t_type = type(text)
    if t_type == unicode:
        return text

    elif t_type == str:
        return text.decode(encoding, errors)
    elif hasattr(text, '__unicode__'):
        return unicode(text)

    return unicode(str(text), encoding, errors)


def unicode_int_list(x):
    """# unicode_int_list: docstring
    args:
        x:    ---    arg
    returns:
        0    ---
    """
    l = x.split('],')
    r_l = []
    for ll in l:
        if not ll:
            continue
        ll = ll.strip(' ').replace(']', '').replace('[', '')
        llll = ll.split(',')
        try:
            r_l.append("""[unicode('''%s''', 'utf-8'), %s, %s]"""%tuple(llll))
        except:
            raise KeyError, str(llll)+ll
    return '['+','.join(r_l)+']'


def force_mix_str(value):
    """ 支持str、int、float

    :param value:
    :return:
    """
    if is_int(value):
        return int(value)
    elif is_float(value):
        return float(value)
    else:
        return force_to_str(value)


def force_mix_unicode(value):
    """ 支持unicode、int、float

    :param value:
    :return:
    """
    if is_int(value):
        return int(value)
    elif is_float(value):
        return float(value)
    else:
        return force_unicode(value)


def force_mix_str_list(value):
    return [force_mix_str(i.strip()) for i in value.split(',') if i] if value not in space else []


def force_mix_unicode_list(value):
    return [force_mix_unicode(i.strip()) for i in value.split(',') if i] if value not in space else []


def force_to_str(x):
    """
    字符串
    :param x:
    :return:
    """
    try:
        x = str(int(x))
    except ValueError:
        x = str(x)

    return force_str(x).strip()


def switch_unicode(x):
    if x is not None:
        try:
            x = int(x)
            return repr(int(x))
        except ValueError:
            return force_unicode(x).strip()
    else:
        return ''


def force_int_list(x):
    try:
        x = str(int(x))
    except ValueError:
        x = x
    except TypeError:
        x = x
    return eval("""[%s]""" % x if x not in [None, '[]', '0', '0.0', 0, 0.0] else"""[]""")


def switch_unicode_list(x):
    if x not in space:
        if not isinstance(x, (str, unicode)):
            return [repr(int(x))]

        data = []
        for i in x.split(','):
            try:
                data.append(repr(int(float(i))))
            except ValueError:
                data.append(force_unicode(i).strip())
        return data
    else:
        return []


mapping = {
    'bool': lambda x: bool(x) if x not in space else False,
    'int': lambda x: int(x) if x not in space else 0,
    'float': lambda x: float(x) if x not in space else 0.0,
    "str": lambda x: force_to_str(x) if x is not None else force_to_str(''),
    'unicode': switch_unicode,
    'int_list': force_int_list,
    'str_list': lambda x: [force_to_str(i.strip()) for i in x.split(',') if i] if x not in space else [],
    'unicode_list': switch_unicode_list,
    'mix_str_list': force_mix_str_list,
    'mix_unicode_list': force_mix_unicode_list,
    'only_one': lambda x: x,    # 原样返回
    'uk': lambda x: x,          # 原样返回
}

""" #####################    转换模板    #####################"""


""" #####################    配置特殊转换模板    #####################"""


def language_mapping(config):
    """ 和语言相关的配置转换
        MUITL_LAN = {'0': 'TW', '1': 'CN', '2': 'EN'}
    """
    mapping_config = {
        '0': {},
        '1': {},
        '2': {},
    }

    for v in config.itervalues():
        error_id = v['error_id']
        mapping_config['0'][error_id] = v['traditional_chinese']
        mapping_config['1'][error_id] = v['chinese']
        mapping_config['2'][error_id] = v['english']
    return mapping_config


mapping_special = {
    'language_mapping': language_mapping,           # 语言转换的配置
}

""" #####################    配置特殊转换模板    #####################"""


def trans_header(sheet_title, sheet_iter):
    headers = {}
    sheet_headers_mapping = {}
    sheet_headers_type_mapping = {}

    # 配置第一行中文文字 忽略
    sheet_iter.next()

    # 配置第二行, 配置名字段
    row2 = sheet_iter.next()
    for idx, col in enumerate(row2):
        if col.internal_value == None:
            continue
        Key_word = str(col.internal_value)
        sheet_headers_mapping[Key_word] = idx

    # 配置第三行, 配置字段类型
    row3 = sheet_iter.next()
    for idx, col in enumerate(row3):
        type_sort = col.internal_value
        if not type_sort:
            continue
        sheet_headers_type_mapping[idx] = type_sort if ',' not in type_sort else type_sort.split(',')

    for k, v in sheet_headers_mapping.iteritems():
        if v not in sheet_headers_type_mapping:
            continue
        headers[k] = (k, v, sheet_headers_type_mapping[v], None)

    return headers


def mapping_func(sheet_sort, value):
    v = mapping[sheet_sort](value)
    return v


def mapping_special_func(sheet_sort, value):
    v = mapping_special[sheet_sort](value)
    return v


def trans(sheet_title, mapping, sheet_iter, special_func_name):
    if special_func_name:
        special_func = mapping[special_func_name]
    else:
        special_func = None

    config = {}
    for row_index, row in enumerate(sheet_iter):
        data = {}
        row_data = [r.internal_value for r in row]
        if any(row_data) and not any(row_data[-50:]):     # 防止配置表后边有太多的空列
            raise KeyError(u'excel:%s 后边有太多的空列' % sheet_title)

        if row_data[0] in ['', None]:
            break

        if row_data[0] == '//':
            continue

        for field, value in mapping.iteritems():
            msg = ''
            if isinstance(value[0], basestring):
                _, index, sheet_sort, check_func = value
                v = row_data[index]
                if isinstance(sheet_sort, basestring):
                    v = mapping_func(sheet_sort, v)
                else:
                    for s_sort in sheet_sort:
                        v = mapping_func(s_sort, v)
                if 'only_one' in sheet_sort:
                    if v:
                        config[field] = v
                elif 'uk' in sheet_sort:
                    data['uk'] = v
                else:
                    data[field] = v

        if special_func:
            config = special_func(config, data)
        uk = data.pop('uk', 1)
        if uk in config:
            raise KeyError('3excel:%s row_index:%s field:%s sheet_sort:%s value:%s msg:%s' %
                                (sheet_title, row_index, 'uk', '', row_data[index], u'id重复'))
        config[uk] = data

    special_func = config.pop('special_func', None)
    if special_func:
        config = mapping_special_func(special_func, config)

    return config


def import_file(filename):
    """导入一个配置
    """
    config_pattern = re.compile('^\w+$').match
    xl = openpyxl.load_workbook(filename=filename, use_iterators=True)
    special_func_name = None
    result = []
    for sheet in xl.worksheets:
        sheet_title = sheet.title.strip()
        if not config_pattern(sheet_title):
            continue
        sheet_iter = sheet.iter_rows()
        trans_mapping = trans_header(sheet_title, sheet_iter)
        config = trans(sheet_title, trans_mapping, sheet_iter, special_func_name)
        result.append((sheet_title, config))

    return result


def import_dir(dirpath):
    config = []
    for filename in os.listdir(dirpath):
        if 'xls' not in filename:
            continue
        filepath = os.path.join(dirpath, filename)
        print 'filepath', filepath
        config.extend(import_file(filepath))
    return config


""" #####################    生成lua文件    #####################"""


def generate_dict_data(writeData, c_value, deep=0):
    """ 字典数据转
    :param writeData:
    :param c_value:
    :return:
    """
    writeData.append('{')
    for k, v in c_value.iteritems():
        if isinstance(k, int):
            writeData.append('\n' + '\t'*deep + '[%s]=' % k)
        elif isinstance(k, str) or isinstance(k, unicode):
            writeData.append('\n' + '\t'*deep + '%s=' % k)
        else:
            writeData.extend([k, '='])

        if isinstance(v, dict):
            generate_dict_data(writeData, v, deep+1)
        elif isinstance(v, list) or isinstance(v, tuple) or isinstance(v, set):
            generate_table_data(writeData, v, deep+1)
        elif isinstance(v, int) or isinstance(v, float):
            writeData.append('%s,' % v)
        elif isinstance(v, unicode):
            writeData.append('"%s",' % v.encode('utf-8'))
        else:
            writeData.append('"%s",' % v)
    writeData.append('\n'+'\t'*deep + '},' if deep else '\n}')


def generate_table_data(writeData, c_value, deep=0):
    """ 列表、集合、元组数据转换
    :param writeData:
    :param c_value:
    :return:
    """
    writeData.append('{')
    for v in c_value:
        if isinstance(v, dict):
            generate_dict_data(writeData, v, deep+1)
        elif isinstance(v, list) or isinstance(v, tuple) or isinstance(v, set):
            generate_table_data(writeData, v, deep+1)
        elif isinstance(v, int) or isinstance(v, float):
            writeData.append('%s,' % v)
        elif isinstance(v, unicode):
            writeData.append('"%s",' % v.encode('utf-8'))
        else:
            writeData.append('"%s",' % v,)
    writeData.append('},')


def generate_lua_config(c_name, c_value):
    if not os.path.exists('config_lua'):
        os.mkdir('config_lua')
    file_lua = open('config_lua/%s.lua' % c_name, 'w')
    writeData = ['local ', c_name, '=']
    if isinstance(c_value, dict):
        generate_dict_data(writeData, c_value)
    elif isinstance(c_value, list) or isinstance(c_value, tuple) or isinstance(c_value, set):
        generate_table_data(writeData, c_value)
    elif isinstance(c_value, int) or isinstance(c_value, float):
        writeData.append('%s,' % c_value)
    else:
        writeData.append('"%s",' % c_value,)
    writeData.append('\nreturn %s' % c_name)
    writeData_str = ''.join(writeData)
    file_lua.write(writeData_str)
    file_lua.close()


""" #####################    生成lua文件    #####################"""


if __name__ == '__main__':

    argvs = sys.argv
    if len(argvs) == 1:
        config = import_file('/Users/kaiqigu/Desktop/lua_test/config/rankup_item_map.xlsx')
        # config = import_dir('/Users/kaiqigu/Desktop/lua_test/config')
    else:
        files = argvs[1:]
        for file in files:
            file = file.strip()
            if not os.path.exists(file):
                print 'ERROR file path: %s' % file
            if os.path.isdir(file):
                try:
                    config = import_dir(file)
                except UnicodeDecodeError:
                    print '出现蜜汁bug, 请尝试单个文件转换...'   # Todo 导入文件夹, 解析excel迷之报错
                    """
                    UnicodeDecodeError: 'utf8' codec can't decode byte 0xb1 in position 168: invalid start byte
                    """
            else:
                config = import_file(file)
    for k, v in config:
        generate_lua_config(k, v)
        print 'generated %s.lua' % k

