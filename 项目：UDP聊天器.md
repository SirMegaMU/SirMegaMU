# 框架

## 发送信息    send_msg()

获得接受方IP地址
指定端口号
获得发送内容
发送信息

## 接受信息    recv_msg()

接收数据
解码
输出文本

## 程序主入口  main()

创建套接字
绑定端口
进入程序循环
打印菜单
接收用户输入的选项
判断用户的选择并调用对应的函数
关闭套接字



# 实现

~~~python
# 程序独立运行时才启动
# 发送信息    send_msg()
# 接受信息    recv_msg()
# 程序主入口  main()

import socket

def send_msg(udp_socket):
    # 获得接受方IP地址
    send_ip = input("请输入接收方的IP地址：")
    # 指定端口号
    send_port = input("请输入接收方的端口：")
    # 获得发送内容
    send_content = input("请输入要发送的内容：")
    # 发送信息
    try:
        udp_socket.sendto(send_content.encode(),(send_ip,int(send_port)))
    except:
        print("发送错误！")
    pass

def recv_msg(udp_socket):
    # 接收数据
    recv_data = udp_socket.recvfrom(1024)

    # 解码
    try:
        recv_content = recv_data[0].decode()
    except:
        print("解码错误")

    # 输出文本
    print("来自{0}用户{1}端口的信息：".format(recv_data[1][0],recv_data[1][1]))
    print(recv_content)

    
    pass

def main():
    # 创建套接字
    udp_soclet = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)

    # 绑定端口
    udp_soclet.bind(("",8080))

    # 进入程序循环
    while True:
    # 打印菜单
        menu = "———————————\n"
        menu+= "聊天器菜单\n"
        menu+="1:发送信息\n"
        menu+="2:接受信息\n"
        menu+="3:退出程序\n———————————\n"
        print(menu)

        # 接收用户输入的选项
        select_num = input("请输入选项:")

        # 判断用户的选择并调用对应的函数
        if int(select_num) == 1:
            print("您选择的是 1：发送信息")
            send_msg(udp_soclet)

        elif int(select_num) == 2:
            print("您选择的是 2：接收信息")
            recv_msg(udp_soclet)

        elif int(select_num) == 3:
            print("您选择的是 3：退出程序")
            print("系统已退出")
            break

        else:
            print("输入错误！")

    # 关闭套接字
    udp_soclet.close
    pass

if __name__ == "__main__":
    main()
    pass
~~~


