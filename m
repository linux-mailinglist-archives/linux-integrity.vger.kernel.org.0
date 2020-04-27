Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4011BAD4E
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Apr 2020 20:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgD0Szr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Apr 2020 14:55:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726223AbgD0Szr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Apr 2020 14:55:47 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03RIaPsn101937;
        Mon, 27 Apr 2020 14:55:40 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30mfbs1edb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Apr 2020 14:55:40 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03RIgmGv120327;
        Mon, 27 Apr 2020 14:55:40 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30mfbs1ecn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Apr 2020 14:55:39 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03RIrJ3F032751;
        Mon, 27 Apr 2020 18:55:38 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 30mcu6ve67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Apr 2020 18:55:38 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03RItZFD62718404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Apr 2020 18:55:35 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D95DA4C046;
        Mon, 27 Apr 2020 18:55:35 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F75D4C040;
        Mon, 27 Apr 2020 18:55:35 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.195.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Apr 2020 18:55:35 +0000 (GMT)
Message-ID: <1588013688.4553.7.camel@linux.ibm.com>
Subject: Re: vfs_getxattr_alloc() problem
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Matthew Garrett <mjg59@google.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
In-Reply-To: <39806fcd829a44e98932dfa383227699@huawei.com>
References: <a47df5af2e2d4bc4bc4757e956c882eb@huawei.com>
         <1587685908.5610.91.camel@linux.ibm.com>
         <39806fcd829a44e98932dfa383227699@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Mon, 27 Apr 2020 14:54:48 -0400
Mime-Version: 1.0
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-27_12:2020-04-27,2020-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004270146
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-04-24 at 14:32 +0000, Roberto Sassu wrote:
> > Hi Roberto,
> > 
> > On Tue, 2020-04-21 at 10:58 +0000, Roberto Sassu wrote:
> > > Hi Mimi
> > >
> > > I found a problem in the calculation of the EVM digest.
> > >
> > > If an xattr is in the security domain, vfs_getxattr() calls xattr_getsecurity(),
> > > which is implemented by LSMs. vfs_getxattr_alloc() instead calls directly
> > > the filesystem function to read xattrs.
> > >
> > > The problem arises for example when you have a file with a portable
> > > signature on the correct SELinux label (with \0) and you set
> > security.selinux
> > > manually:
> > >
> > > setfattr -n security.selinux -v "system_u:object_r:bin_t:s0" cat
> > >
> > > Although the length passed is 26 bytes (without \0), you get:
> > >
> > > # attr -l cat
> > > Attribute "selinux" has a 27 byte value for cat
> > >
> > > which includes \0.
> > >
> > > From user space, evmctl does not complain (the signature is ok) because
> > > it calculates the EVM digest with \0, but EVM verification fails (because it
> > > calculates the digest without \0).
> > >
> > > Should this problem be fixed?
> > 
> > I don't seem to be having any problems verifying the EVM immutable &
> > portable signatures.  To test, I've copied a properly labeled file
> > twice, once with the "--preserve=xattr" and once without it.  I signed
> > the properly labeled file with the EVM immutable & portable signature.
> >  On the other file, I first set the selinux label before signing it.
> > If there was a problem manually writing the SELinux label, the
> > security.evm labels would be different, which they aren't.
> 
> [root@vm demo]# ls -lZ /bin/cat
> -rwxr-xr-x. 1 root root system_u:object_r:bin_t:s0 85520 Apr 24 16:20 /bin/cat
> [root@vm demo]# evmctl sign -o -a sha256 --imahash --key $PWD/signing_key.pem /bin/cat -v -v
> hash(sha256): 0404d3d78d8249317ed50056ec7d04da382488f36a6127f4e9161792d97f13e10bc6
> name: security.selinux, size: 27
> 73797374656d5f753a6f626a6563745f723a62696e5f743a733000
> no xattr: security.SMACK64
> no xattr: security.apparmor
> name: security.ima, size: 34
> 0404d3d78d8249317ed50056ec7d04da382488f36a6127f4e9161792d97f13e10bc6
> no xattr: security.capability
> calc_evm_hash:532 hmac_misc (24): 0000000000000000000000000000000000000000ed810000
> hash(sha256): 331e36ce1b32374a22e12df28b58d79536c0ee97ba01451bd60343191c073b55
> calc_keyid_v2:735 keyid: aecec286
> keyid: aecec286
> evm/ima signature: 520 bytes
> ...
> [root@vm demo]# cat
> ^C
> [root@vm demo]# setfattr -n security.selinux -v "system_u:object_r:bin_t:s0" /bin/cat

In the past, when I looked at writing the same SELinux label, there
was some performance improvement that only updated the label if the
label actually changed.  Unless things have changed since, I don't
think the same selinux label is rewritten.

> [root@vm demo]# evmctl verify -o -a sha256 --imahash /bin/cat -v -v
> calc_keyid_v2:735 keyid: aecec286
> keyid: aecec286
> key 1: aecec286 /etc/keys/x509_evm.der
> name: security.selinux, size: 27
> 73797374656d5f753a6f626a6563745f723a62696e5f743a733000
> no xattr: security.SMACK64
> no xattr: security.apparmor
> name: security.ima, size: 34
> 0404d3d78d8249317ed50056ec7d04da382488f36a6127f4e9161792d97f13e10bc6
> no xattr: security.capability
> calc_evm_hash:532 hmac_misc (24): 0000000000000000000000000000000000000000ed810000
> hash(sha256): 331e36ce1b32374a22e12df28b58d79536c0ee97ba01451bd60343191c073b55
> /bin/cat: verification is OK
> [root@vm demo]# cat
> -bash: /usr/bin/cat: Permission denied
> [root@vm demo]#
> 
> It fails because the actual xattr in the filesystem is:
> 
> name: security.selinux, size: 26
> 73797374656d5f753a6f626a6563745f723a62696e5f743a7330

Looking at security/selinux/hooks.c:  I'm seeing a
comment selinux_inode_setxattr() that says:

/* We strip a nul only if it is at the end, otherwise the
 * context contains a nul and we should audit that */

Mimi


