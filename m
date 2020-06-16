Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822B81FC190
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jun 2020 00:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgFPWba (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 18:31:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43690 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725849AbgFPWba (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 18:31:30 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05GM2fVq077169;
        Tue, 16 Jun 2020 18:30:27 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31q6hg0k54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Jun 2020 18:30:27 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05GMP6Yw012884;
        Tue, 16 Jun 2020 22:30:26 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02dal.us.ibm.com with ESMTP id 31q6c7rdtf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Jun 2020 22:30:26 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05GMUPnl61931964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jun 2020 22:30:25 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D42C78064;
        Tue, 16 Jun 2020 22:30:25 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2074978063;
        Tue, 16 Jun 2020 22:30:25 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 16 Jun 2020 22:30:24 +0000 (GMT)
To:     linux-integrity <linux-integrity@vger.kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Subject: Stalled /dev/tpmr0 when context size increases to support RSA 3072
 bit keys
Message-ID: <b404211d-f540-d2bd-eaf6-2b616bebb899@linux.ibm.com>
Date:   Tue, 16 Jun 2020 18:30:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-16_13:2020-06-16,2020-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 cotscore=-2147483648 mlxscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 spamscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006160146
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

I am upgrading libtpms's TPM 2 to support RSA 3072 keys (increase 
context size to 2680 bytes) and wanted to test an upgrade from previous 
version (0.7.2) which only supports RSA 2048 keys to this newer version 
(git master). I tried to run this with clevis setting up automatic 
decryption via TPM 2, but it doesn't work and it seems the issue is due 
to a stall of /dev/tpmr0 that doesn't respond anymore.


So here's a simple sequence with added 'set -x' into clevis-encrypt-tpm2 
and clevis-decrypt-tpm2:

All good in the encryption part:

[root@localhost ~]# echo hi | clevis encrypt tpm2 '{"key":"rsa"}' > 
hi-rsa3072.jwe
+ case "$TPM2TOOLS_VERSION" in
+ tpm2_createprimary -Q -C o -g sha256 -G rsa -c 
/tmp/tmp.cqg0DMjuL4/primary.context
+ set +x
+ case "$TPM2TOOLS_VERSION" in
+ tpm2_create -Q -g sha256 -C /tmp/tmp.cqg0DMjuL4/primary.context -u 
/tmp/tmp.cqg0DMjuL4/jwk.pub -r /tmp/tmp.cqg0DMjuL4/jwk.priv -a 
'fixedtpm|fixedparent|noda|adminwithpolicy|userwithauth' -i-
+ set +x

The decryption part stalls:

[root@localhost ~]# clevis decrypt < hi-rsa3072.jwe 2>&1 | tee strace.log
+ case "$TPM2TOOLS_VERSION" in
+ tpm2_createprimary -Q -C o -g sha256 -G rsa -c 
/tmp/tmp.9W2U5Fw8HX/primary.context
+ set +x
+ case "$TPM2TOOLS_VERSION" in
+ tpm2_load -Q -C /tmp/tmp.9W2U5Fw8HX/primary.context -u 
/tmp/tmp.9W2U5Fw8HX/jwk.pub -r /tmp/tmp.9W2U5Fw8HX/jwk.priv -c 
/tmp/tmp.9W2U5Fw8HX/load.context -V
INFO on line: "362" in file: "lib/files.c": Assuming tpm context file
INFO on line: "293" in file: "lib/files.c": load: 
TPMS_CONTEXT->savedHandle: 0x80000000
^Z
[1]+  Stopped                 clevis decrypt < hi-rsa3072.jwe 2>&1 | tee 
strace.log


Note: I put the tool in the background using ctrl-Z and now I can run 
this stalled command and it works!

[root@localhost ~]# tpm2_load -Q -C /tmp/tmp.9W2U5Fw8HX/primary.context 
-u /tmp/tmp.9W2U5Fw8HX/jwk.pub -r /tmp/tmp.9W2U5Fw8HX/jwk.priv -c 
load.context -V
INFO on line: "362" in file: "lib/files.c": Assuming tpm context file
INFO on line: "293" in file: "lib/files.c": load: 
TPMS_CONTEXT->savedHandle: 0x80000000
INFO on line: "190" in file: "lib/files.c": Save 
TPMS_CONTEXT->savedHandle: 0x80000000


I know that the above is stalled because I had strace'd it:

openat(AT_FDCWD, "/dev/tpmrm0", O_RDWR|O_NONBLOCK) = 3

[...]

write(3, "\200\1\0\0\0;\0\0\1v@\0\0\7@\0\0\7\0 
\316)s\332fV_\177\326\303\221#"..., 59) = 59
poll([{fd=3, events=POLLIN}], 1, -1)    = 1 ([{fd=3, revents=POLLIN}])
read(3, "\200\1\0\0\0000\0\0\0\0\2\0\0\0\0 
\303cQ\225\0\235F\4-\225:y\353\254\220\247"..., 4096) = 48
openat(AT_FDCWD, "/tmp/tmp.9WItRVOByv/primary.context", O_RDONLY) = 4
fstat(4, {st_mode=S_IFREG|0644, st_size=3036, ...}) = 0
brk(NULL)                               = 0x55fc8d415000
brk(0x55fc8d436000)                     = 0x55fc8d436000
read(4, 
"\272\334\300\336\0\0\0\1@\0\0\1\200\0\0\0\0\0\0\0\0\0\0B\v\302\0\0\0\0\nr"..., 
4096) = 3036
lseek(4, -3036, SEEK_CUR)               = 0
write(2, "INFO on line: \"362\" in file: \"li"..., 44INFO on line: "362" 
in file: "lib/files.c": ) = 44
write(2, "Assuming tpm context file", 25Assuming tpm context file) = 25
write(2, "\n", 1
)                       = 1
read(4, 
"\272\334\300\336\0\0\0\1@\0\0\1\200\0\0\0\0\0\0\0\0\0\0B\v\302\0\0\0\0\nr"..., 
4096) = 3036
write(2, "INFO on line: \"293\" in file: \"li"..., 44INFO on line: "293" 
in file: "lib/files.c": ) = 44
write(2, "load: TPMS_CONTEXT->savedHandle:"..., 43load: 
TPMS_CONTEXT->savedHandle: 0x80000000) = 43
write(2, "\n", 1
)                       = 1
write(3, 
"\200\1\0\0\n\216\0\0\1a\0\0\0\0\0\0\0B\200\0\0\0@\0\0\1\nr\0@]\234"..., 
2702) = 2702
poll([{fd=3, events=POLLIN}], 1, -1)    = 1 ([{fd=3, revents=POLLIN}])
read(3, "\200\1\0\0\0\16\0\0\0\0\200\377\377\377", 4096) = 14
close(4)                                = 0
getpid()                                = 1591
getpid()                                = 1591
write(3, "\200\2\0\0\1{\0\0\1W\200\377\377\377\0\0\0I\2\0\0\0\0 
\203\33\326qO\214\r\0"..., 379) = 379
poll([{fd=3, events=POLLIN}], 1, -1

It's stuck polling on /dev/tpmrm0.

    Any ideas?


     Stefan


