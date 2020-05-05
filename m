Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491A91C63DF
	for <lists+linux-integrity@lfdr.de>; Wed,  6 May 2020 00:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgEEW1m (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 5 May 2020 18:27:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41864 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728934AbgEEW1l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 May 2020 18:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588717659;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type; bh=n2OQZjJ8JTnkDhSt73P8z9iNu4TsZnBsXeWIE1i9S0I=;
        b=PXYv/vUyRX3/R30N2fdnN1qDRYzLHIMFlcbYsLuHExrpY/GLFktMi51es+s8PG4xvU6bCo
        qAjqfXeFv6fd6NTCEZKnZEoHu6aAJgmhT9QMMezhoVlSzlRXhhCGY1T92OesBguPaFIvsA
        EiXhuxL+0ILVrLAwzeSVV3omrLC7vmo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-5Kwixm9eNT-s1qilqc3SDA-1; Tue, 05 May 2020 18:27:35 -0400
X-MC-Unique: 5Kwixm9eNT-s1qilqc3SDA-1
Received: by mail-qv1-f69.google.com with SMTP id m20so198245qvy.13
        for <linux-integrity@vger.kernel.org>; Tue, 05 May 2020 15:27:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:reply-to
         :mime-version:content-disposition;
        bh=n2OQZjJ8JTnkDhSt73P8z9iNu4TsZnBsXeWIE1i9S0I=;
        b=YnoxdNscI/Ew6SvZRGqLLzs48Qdg/5lFWsci42/i7C8uUNP69jJ0MlOHsOOAKeQaWl
         jAQtFVBsxGjynFdpkTuezwUOlh3X80IaET5GV7dfDlgu2BK09XBHfA+A/RNzCZQ5dKvV
         MT5JcTbrq3s1Y/ukl6WSTc9p88Opfa985UEiy2cpKZorLip3vAejsQrtmNAKJoNSr5Yb
         KfktwHwlwuo6yU82wNqOrgocKpVo6elGK2yROQxbRlUlMXqo5BZovi6bbcgWUgISQ1++
         7zfIW9uH8VJtvi1BcwqRmrkC2QqfKBk+daJdiRxA0ludU0a5keGeZ9pIdIjFg4xToq/a
         pfwQ==
X-Gm-Message-State: AGi0PuY/H3QoSQvuFf/BLVUjE4nz03elwlavICk+vjDERAztJ8moxRtH
        kYJzRwNMDiB/xSbigjdvT6EJUJqsqzEwgbH9u2eKsNKdiotBE+59WupqJaPwL9qNz8yfN3LXbvS
        OZXbsoTt951B3q/lgB7i7paP5AZcF
X-Received: by 2002:a37:7646:: with SMTP id r67mr5574258qkc.499.1588717654461;
        Tue, 05 May 2020 15:27:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypKWgOvY0IvtV76BsUdRbS7/WWSz9Ov9Z/fIZPHiCMus0afRcisD15I0S3FgHTewZ/2YiuHzBA==
X-Received: by 2002:a37:7646:: with SMTP id r67mr5574202qkc.499.1588717653405;
        Tue, 05 May 2020 15:27:33 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id b136sm196920qkg.86.2020.05.05.15.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 15:27:32 -0700 (PDT)
Date:   Tue, 5 May 2020 15:27:31 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Disparity in tpm pcr5 value
Message-ID: <20200505222731.whnkisag7tlrbcie@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On some systems we've had reports of the value of pcr5 doesn't match the digests in the tpm event log.
It looks like I'm able to reproduce here with 5.7-rc4 on a dell system using this parser:

https://github.com/ValdikSS/binary_bios_measurements_parser

Any thoughts on where to start digging? Is there another tool I should use to parse this?

Regards,
Jerry

# ./binary_bios_measurements
Num PCR EV_type  PCR_value                                Size Valid Data
0   0   8        ad8888919ff82aa70016f43aadd2893881af1f1e 12   0     b'1\x00.\x008\x00.\x000\x00\x00\x00'
1   0   80000008 26d4548e639c33d3b8d4c849851a034e2af871d7 16   0     b'\x00\x00\xf6\xff\x00\x00\x00\x00\x00\x00\n\x00\x00\x00\x00\x00'
2   0   80000008 b76c595f5ef9f14ad903e57ae59a68006e36c2ae 16   0     b'\x00\x00\xdb\xff\x00\x00\x00\x00\x00\x00\x16\x00\x00\x00\x00\x00'
3   0   80000008 8e39ed994a34f4b37ec63f413121030ee1a7ff3f 16   0     b'\x00\x00\xcd\xff\x00\x00\x00\x00\x00\x00\n\x00\x00\x00\x00\x00'
4   0   80000008 1e30a06c031388e998f96422a55475339f3a3cd4 16   0     b'\x00\x001\xff\x00\x00\x00\x00\x00\x00G\x00\x00\x00\x00\x00'
5   7   80000001 57cd4dc19442475aa82743484f3b1caa88e142b8 53   1     b'a\xdf\xe4\x8b\xca\x93\xd2\x11\xaa\r\x00\xe0\x98\x03+\x8c\n\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00'
6   7   80000001 24e3773803268f57884ced30e1a481d20f1460c6 1391 1     b'a\xdf\xe4\x8b\xca\x93\xd2\x11\xaa\r\x00\xe0\x98\x03+\x8c\x02\x00\x00\x00\x00\x00\x00\x00K\x05\x00\x00\x00\x00'
7   7   80000001 13f02fbc7383ed7c89017e0b32f60e38e282056c 1598 1     b'a\xdf\xe4\x8b\xca\x93\xd2\x11\xaa\r\x00\xe0\x98\x03+\x8c\x03\x00\x00\x00\x00\x00\x00\x00\x18\x06\x00\x00\x00\x00'
8   7   80000001 051007eb692148b094ca5feeac98e767984e7dd4 3179 1     b'\xcb\xb2\x19\xd7:=\x96E\xa3\xbc\xda\xd0\x0egeo\x02\x00\x00\x00\x00\x00\x00\x00G\x0c\x00\x00\x00\x00'
9   7   80000001 16cfacc569aeaf0f5ad9f306a88298f46dc88418 766  1     b'\xcb\xb2\x19\xd7:=\x96E\xa3\xbc\xda\xd0\x0egeo\x03\x00\x00\x00\x00\x00\x00\x00\xd8\x02\x00\x00\x00\x00'
10  2   80000004 32865d7b456e6a47d0333ad1432b0220220fcd13 60   0     b'\x18\x10\xbcn\x00\x00\x00\x00 x\x05\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x1c\x00\x00\x00\x00\x00'
11  2   80000004 32865d7b456e6a47d0333ad1432b0220220fcd13 60   0     b'\x18\x10\xbcn\x00\x00\x00\x00 x\x05\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x1c\x00\x00\x00\x00\x00'
12  2   80000004 2ae3306aab74556075b4e23add02cc19329178f5 60   0     b'\x18\x10\xedn\x00\x00\x00\x008\x86\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x1c\x00\x00\x00\x00\x00'
13  2   80000004 76bbf6ccd7cbd111bd4befcc1ed8469e038f1b26 60   0     b'\x18\x10\xbcn\x00\x00\x00\x00\xc8|\x05\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x1c\x00\x00\x00\x00\x00'
14  2   80000004 76bbf6ccd7cbd111bd4befcc1ed8469e038f1b26 60   0     b'\x18\x10\xbcn\x00\x00\x00\x00\xc8|\x05\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x1c\x00\x00\x00\x00\x00'
15  2   80000004 214454ad2c20e85c5de6ad4de3b9ddbd869ef977 56   0     b'\x18\xc0\xefl\x00\x00\x00\x00\x00\xe8\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00'
16  2   80000004 a64ecb2660432f0f4d790eec5be27eca9df4d05e 56   0     b'\x18@\xf0l\x00\x00\x00\x00`n\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00'
17  2   80000004 7b8bff474cc39a4fa168367796397218157ad5d1 56   0     b'\x18P\xeel\x00\x00\x00\x00\xc0~\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00'
18  2   80000004 9ef514ccf9354dbf0597fcd349267f2ed29fa628 56   0     b'\x18@\xedl\x00\x00\x00\x00\xa0\x8e\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00'
19  2   80000004 85e0177e06c5c5cc9c2aedbeda7d28689fd71fbf 56   0     b'\x18P\xeel\x00\x00\x00\x00\xe0~\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00'
20  2   80000004 a7a14ef0c07eac5895e87ed8855e1a0736c81402 56   0     b'\x18p\xeel\x00\x00\x00\x00@Z\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00'
21  2   80000004 dc10996559a93b23ab23033d237f8f73fad3cb9c 56   0     b'\x18\xf0\xeal\x00\x00\x00\x00`T\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00'
22  2   80000004 145e997924e71cc6785bf697ab84302b610e75be 56   0     b'\x18\xc0\xebl\x00\x00\x00\x00@\x82\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00'
23  2   80000004 43d04b3bf9c215927f06b4fe55154924843657a5 56   0     b'\x18p\xe7l\x00\x00\x00\x00\xe0\x12\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00'
24  2   80000004 57bbd49438517ae6c0a9c48b22721bcda14f9082 56   0     b'\x18`\xeel\x00\x00\x00\x00`a\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00'
25  2   80000004 37c9f38aba62a53743c8b5a07c2a59adc543a3d9 56   0     b'\x18`\xe8l\x00\x00\x00\x00\xc0*\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00'
26  2   80000004 25d704f7ad7e6f9a4ea5fe5095793ce52856996a 56   0     b'\x18\x90\xe0l\x00\x00\x00\x00\xe0\x8d\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00'
27  2   80000004 5dd0e780e4df7b359968975423acbff9df8bb98f 56   0     b'\x18p\xe7l\x00\x00\x00\x00\x80\x1d\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00'
28  2   80000004 36d2c0f058ee6fe83cb0ccaf1555ce32b8c5d0da 56   0     b'\x18\xe0\xe7l\x00\x00\x00\x00\xc0\xa7\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00'
29  2   80000004 f0380b8645e3f24dec76f99bf191d64b6a68bad6 56   0     b'\x18\xa0\xd5l\x00\x00\x00\x00@\xaf\x05\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00'
30  2   80000004 e89cacb9d950b225706317dd298d3b7d4dd5b1e6 56   0     b'\x18\xf0\xe8l\x00\x00\x00\x00\xe0\x97\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00'
31  2   80000004 391d3d24963abcd3a3ea2ffcb5e86c392105b71b 56   0     b'\x18\xe0\xe0l\x00\x00\x00\x00\x80\x1c\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00'
32  2   80000004 83b82942a5b80ae6ae01e950f46fba63d8da5c0a 56   0     b'\x18\xa0\xe0l\x00\x00\x00\x00\x80W\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00'
33  2   80000004 9065f2578ee3134087e601314459d6f38b513418 56   0     b'\x18 \xd6l\x00\x00\x00\x00\xc0\xac\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00'
34  2   80000004 f47651fa5acd3a725a7d6f31d804285dc0648e0a 56   0     b'\x18\x80\xe7l\x00\x00\x00\x00\xa0\xc3\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00'
35  2   80000004 6fdf40c95ceb51b4e1bd3ed9f1eef56ee613563a 56   0     b'\x18`\xeel\x00\x00\x00\x00\x00^\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00'
36  2   80000004 9f2cffe468b3ba675567a446e684857f7528912b 56   0     b'\x18\xf0\xd6l\x00\x00\x00\x00\x80\xde\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00'
37  2   80000004 19cc99f2facbf60777543d40968192c3c7644501 56   0     b'\x18\xb0\xe7l\x00\x00\x00\x00\xe0\x9b\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00'
38  2   80000004 617ae7301eb417abe5665f7abd47dd2e870b6e35 56   0     b'\x18\x80\xe7l\x00\x00\x00\x00\x80\xca\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00'
39  2   80000004 3704d4e2b20267d020c76eed0882efc7b7954620 56   0     b'\x18\xe0\xe7l\x00\x00\x00\x00\x00`\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00'
40  2   80000004 00e103235a8ee840a96b52cb1d7f47b16450da97 56   0     b'\x18\x10\xd7l\x00\x00\x00\x00\x00\xed\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00'
41  2   80000004 75a392c9ff42e3a69f7ea543e4457ad1d509aecd 56   0     b'\x18 \xcal\x00\x00\x00\x00`?\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00'
42  2   80000004 7ec8fd43f660c959021cf52c7bb8d018609bdb75 56   0     b'\x18\xc0\xc5l\x00\x00\x00\x00\x80\x18\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00'
43  2   80000004 430d68b6106663623dcbd3cd020e267aa2ccca43 56   0     b'\x18@\xd7l\x00\x00\x00\x00\xe0\xb8\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00'
44  2   80000004 ef51b25f860a35a6505386fb26902ea894d05e28 32   0     b'\x18\xb0\x84l\x00\x00\x00\x00\x90\xe2=\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
45  4   80000003 f7d65cff12d4938be4e1ddc11f7d3fa8a49f8e24 132  0     b'\x18 \x91k\x00\x00\x00\x00`|\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00d\x00\x00\x00\x00\x00'
46  4   80000003 01a4ba7205cc9c54bb390cf1c39ed83c76437624 112  0     b'\x18\xb0\x10k\x00\x00\x00\x00\xe0\xa7\x0b\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00P\x00\x00\x00\x00\x00'
47  1   b        4e68f6b888080ac1c1ad40b096e601b95d83072d 32   0     b'\x01\x00\x00\x00\x00\x00\x00\x00\x05\xa6\xdd?n\xa7FO\xad)\x12\xf4S\x1b=\x08\x18\xec\x85l\x00\x00'
48  5   80000002 e59aacecb2fa41c6537811ea25634b0c970a1d8d 56   0     b'a\xdf\xe4\x8b\xca\x93\xd2\x11\xaa\r\x00\xe0\x98\x03+\x8c\t\x00\x00\x00\x00\x00\x00\x00\x06\x00\x00\x00\x00\x00'
49  5   80000002 aa1d7289bb55409d20db101b61669dd5e2392e8d 150  0     b'a\xdf\xe4\x8b\xca\x93\xd2\x11\xaa\r\x00\xe0\x98\x03+\x8c\x08\x00\x00\x00\x00\x00\x00\x00f\x00\x00\x00\x00\x00'
50  5   80000002 1363c1ca4ba7f8879bdb169c12d635add6728e06 166  0     b'a\xdf\xe4\x8b\xca\x93\xd2\x11\xaa\r\x00\xe0\x98\x03+\x8c\x08\x00\x00\x00\x00\x00\x00\x00v\x00\x00\x00\x00\x00'
51  5   80000002 5b4fa10062648d4216b0fedeff761f28a0ad3784 202  0     b'a\xdf\xe4\x8b\xca\x93\xd2\x11\xaa\r\x00\xe0\x98\x03+\x8c\x08\x00\x00\x00\x00\x00\x00\x00\x9a\x00\x00\x00\x00\x00'
52  5   80000007 cd0fdb4531a6ec41be2753ba042637d6e5f7f256 40   1     b'Calling EFI Application from B'
53  0   4        9069ca78e7450a285173431b3e52c5c25299e473 4    1     b'\x00\x00\x00\x00'
54  1   4        9069ca78e7450a285173431b3e52c5c25299e473 4    1     b'\x00\x00\x00\x00'
55  2   4        9069ca78e7450a285173431b3e52c5c25299e473 4    1     b'\x00\x00\x00\x00'
56  3   4        9069ca78e7450a285173431b3e52c5c25299e473 4    1     b'\x00\x00\x00\x00'
57  4   4        9069ca78e7450a285173431b3e52c5c25299e473 4    1     b'\x00\x00\x00\x00'
58  5   4        9069ca78e7450a285173431b3e52c5c25299e473 4    1     b'\x00\x00\x00\x00'
59  6   4        9069ca78e7450a285173431b3e52c5c25299e473 4    1     b'\x00\x00\x00\x00'
60  7   4        9069ca78e7450a285173431b3e52c5c25299e473 4    1     b'\x00\x00\x00\x00'
61  5   80000006 c551867d467d7b41cff4f35373ea4f38a961e183 484  1     b'EFI PART\x00\x00\x01\x00\\\x00\x00\x00\xa0&\xcaE\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00'
62  4   80000003 c5997af577c074aac5cf0fb290f24bec27618d73 88   0     b'\x18\x00Ln\x00\x00\x00\x00X{\x12\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x008\x00\x00\x00\x00\x00'
63  4   80000003 112effa3c85e7620c8544e790d0feaa8af0e48fc 41   0     b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
64  8   d        b5cdd08fbb1631e2808be85875c9891895d2de15 21   0     b'grub_cmd set pager=1\x00'
65  8   d        0a6d22c33ac9cf9246e0fe836be811be2ee41eda 46   0     b'grub_cmd [ -f (hd0,gpt1)/EFI/r'
66  8   d        fe27d614d9b9d2154c5e6e112a6510b77584d874 51   0     b'grub_cmd load_env -f (hd0,gpt1'
67  8   d        eb884be5efb176883b4268d3bd06f3a4cd4fa905 14   0     b'grub_cmd [  ]\x00'
68  8   d        0e9c8c403f860352baf1c7aaa0e120ac9364d3cc 80   0     b'grub_cmd set default=c79ec5c3b'
69  8   d        11aeae3e11208de5c3384f2d437e5c501a6ef356 21   0     b'grub_cmd [ xy = xy ]\x00'
70  8   d        dd7e62298c965febcd2b6ddf96ca878c5d63d2ed 34   0     b'grub_cmd menuentry_id_option=-'
71  8   d        ac8fb28e9bace9bf0c33fc0f2eadb7ac90431bf9 36   0     b'grub_cmd export menuentry_id_o'
72  8   d        eb884be5efb176883b4268d3bd06f3a4cd4fa905 14   0     b'grub_cmd [  ]\x00'
73  8   d        304bb9259cd57a92ed7607b99cd9cd9e8d3da363 44   0     b'grub_cmd serial --speed=115200'
74  8   d        231745c43d650f0ac0a865f3c2f4c60b3af3f3b8 39   0     b'grub_cmd terminal_input serial'
75  8   d        ea8de8f0b52991c1f2b6ec8d51eea9b3bbf7ff0c 40   0     b'grub_cmd terminal_output seria'
76  8   d        11aeae3e11208de5c3384f2d437e5c501a6ef356 21   0     b'grub_cmd [ xy = xy ]\x00'
77  8   d        d65e183600be132851d123839bf39344e7b96b0d 32   0     b'grub_cmd set timeout_style=men'
78  8   d        714c8a0d8016cf3a55618a3349203867be7569ff 23   0     b'grub_cmd set timeout=5\x00'
79  8   d        791ae99b5a33b9764ea95f9e2e48bcca0b12820f 27   0     b'grub_cmd set tuned_params=\x00'
80  8   d        1169abf452ea560f5963cf384b9dafb3fdf88832 27   0     b'grub_cmd set tuned_initrd=\x00'
81  8   d        199fd5ffcd827c5576a37fa1e66ec68c48a7dc7a 47   0     b'grub_cmd [ -f (hd0,gpt1)/EFI/r'
82  8   d        2a804d25c133fa9d5f181aa8db30f0e29156f27a 25   0     b'grub_cmd insmod part_gpt\x00'
83  8   d        783ad2b4fe10dc3e8726a5d06b60db124b56a9d9 20   0     b'grub_cmd insmod xfs\x00'
84  8   d        a073e5a51628feee24d89786b502def7d961519e 27   0     b'grub_cmd set root=hd0,gpt2\x00'
85  8   d        11aeae3e11208de5c3384f2d437e5c501a6ef356 21   0     b'grub_cmd [ xy = xy ]\x00'
86  8   d        678a091eec5a2b373744658d89abcff6f2be7577 155  0     b'grub_cmd search --no-floppy --'
87  8   d        2a804d25c133fa9d5f181aa8db30f0e29156f27a 25   0     b'grub_cmd insmod part_gpt\x00'
88  8   d        1dba39e5c5c90245a3ee3ac34091e1e7415603b3 20   0     b'grub_cmd insmod fat\x00'
89  8   d        632cc8afeec2f091a138fd8a7e1ab309070d3b06 27   0     b'grub_cmd set boot=hd0,gpt1\x00'
90  8   d        11aeae3e11208de5c3384f2d437e5c501a6ef356 21   0     b'grub_cmd [ xy = xy ]\x00'
91  8   d        5e38ceac52fb8abbad6529f84a9f9601f73dfde7 128  0     b'grub_cmd search --no-floppy --'
92  8   d        a4a1b04aa90b27afa5ca11d3d51b4c2a1aba2fe0 237  0     b'grub_cmd set default_kernelopt'
93  8   d        ad4d7d4eef95339a123caef0bb8902065fc9fc4e 23   0     b'grub_cmd insmod blscfg\x00'
94  8   d        7e4aa849251c9f017ea05a71d5055c8908ec1d69 16   0     b'grub_cmd blscfg\x00'
95  8   d        cf4bd5c908a3f3711784d6ba7cf9be38cda02cd5 49   0     b'grub_cmd [ -f (hd0,gpt1)/EFI/r'
96  8   d        5f0d6daf838ba8bf4f11d187c0e7de102afcbe5d 77   0     b'grub_cmd [ -z (hd0,gpt1)/EFI/r'
97  8   d        574b7ff1e615922423e4f1f73e32301b93604fa6 20   0     b'grub_cmd load_video\x00'
98  8   d        11aeae3e11208de5c3384f2d437e5c501a6ef356 21   0     b'grub_cmd [ xy = xy ]\x00'
99  8   d        7bb7ebf34270485e684f887c8c9b10cd0f8f1603 26   0     b'grub_cmd insmod all_video\x00'
100 8   d        a6db01860adfad3501be49c6a5bf0aaac8918797 30   0     b'grub_cmd set gfx_payload=keep\x00'
101 8   d        0f45725024a04bfb1c187fc218963611de8be024 21   0     b'grub_cmd insmod gzio\x00'
102 8   d        ec27dc64afb373081538432a8d9c33c2223d4f44 265  0     b'grub_cmd linux (hd0,gpt2)/vmli'
103 9   d        f9273bb0fcee56e3fadc1eaee1c0e9dcb60acd05 21   0     b'grub_linuxefi Kernel\x00'
104 4   80000003 6431207e72e2afef49a6085537183615babf0041 41   0     b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
105 8   d        35134d24af3326c885c6d1688cc68549ace61e4c 270  0     b'grub_kernel_cmdline (hd0,gpt2)'
106 8   d        fced1da7dce679288fcf4dda5bf79d0c59b4ea58 68   0     b'grub_cmd initrd (hd0,gpt2)/ini'
107 9   d        9d922642afba379a9482cfff0da4adea761db695 21   0     b'grub_linuxefi Initrd\x00'

Final PCRs:
PCR-00: 25 67 78 88 B7 EA 26 DB BB FA CF F6 C2 69 16 1D 2B 62 C5 A9
PCR-01: 54 87 03 64 40 7D C0 89 C6 5C C3 F6 AA F7 DE 71 02 94 50 A3
PCR-02: EF 47 39 CE BE 6B 4C 3F 36 2A F9 0D 1A C1 E8 EA 08 0E 4E BA
PCR-03: B2 A8 3B 0E BF 2F 83 74 29 9A 5B 2B DF C3 1E A9 55 AD 72 36
PCR-04: 2D DA A7 93 B2 B9 9C 6B 00 22 24 B8 B4 7E 01 1A 75 9B 73 C1
PCR-05: AB 77 A3 25 EA 53 59 C6 A6 31 60 CA EC EE 4C 34 73 4D E6 71
PCR-06: B2 A8 3B 0E BF 2F 83 74 29 9A 5B 2B DF C3 1E A9 55 AD 72 36
PCR-07: 1B 25 5A D4 8F DD 54 BF 5F FF AB C1 A6 9F FF DE F7 CB B5 4D
PCR-08: 58 BC 6D 08 02 04 CE 30 F4 51 73 AF 22 BA 67 2E B5 38 35 E0
PCR-09: 66 83 02 65 8B E0 F7 16 BD D2 8B 79 AC E5 27 C5 9D 6D A6 CD
PCR-10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
PCR-11: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
PCR-12: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
PCR-13: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
PCR-14: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
PCR-15: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
PCR-16: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
PCR-17: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
PCR-18: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
PCR-19: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
PCR-20: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
PCR-21: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
PCR-22: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
PCR-23: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
# tpm2_pcrread --tcti tabrm 
sha1:
   0 : 0x25677888B7EA26DBBBFACFF6C269161D2B62C5A9
   1 : 0x54870364407DC089C65CC3F6AAF7DE71029450A3
   2 : 0xEF4739CEBE6B4C3F362AF90D1AC1E8EA080E4EBA
   3 : 0xB2A83B0EBF2F8374299A5B2BDFC31EA955AD7236
   4 : 0x2DDAA793B2B99C6B002224B8B47E011A759B73C1
   5 : 0xF7C99B78BE3720946E360B2B2772642614CF9DF0
   6 : 0xB2A83B0EBF2F8374299A5B2BDFC31EA955AD7236
   7 : 0x1B255AD48FDD54BF5FFFABC1A69FFFDEF7CBB54D
   8 : 0x58BC6D080204CE30F45173AF22BA672EB53835E0
   9 : 0x668302658BE0F716BDD28B79ACE527C59D6DA6CD
   10: 0xA06D54BBA19CD1357B3D7CF4722DB0C6AC749FC5
   11: 0x0000000000000000000000000000000000000000
   12: 0x0000000000000000000000000000000000000000
   13: 0x0000000000000000000000000000000000000000
   14: 0x0000000000000000000000000000000000000000
   15: 0x0000000000000000000000000000000000000000
   16: 0x0000000000000000000000000000000000000000
   17: 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
   18: 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
   19: 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
   20: 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
   21: 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
   22: 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
   23: 0x0000000000000000000000000000000000000000
sha256:

