Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BECC31B6A28
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2020 01:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgDWXv5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Apr 2020 19:51:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38306 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725936AbgDWXv4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Apr 2020 19:51:56 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03NNfOWL060889
        for <linux-integrity@vger.kernel.org>; Thu, 23 Apr 2020 19:51:55 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30kk5stpc5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 23 Apr 2020 19:51:55 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 24 Apr 2020 00:51:28 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 24 Apr 2020 00:51:26 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03NNpowC24313896
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Apr 2020 23:51:50 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BA1B11C04C;
        Thu, 23 Apr 2020 23:51:50 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AF6F11C052;
        Thu, 23 Apr 2020 23:51:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.178.107])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Apr 2020 23:51:49 +0000 (GMT)
Subject: Re: vfs_getxattr_alloc() problem
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Matthew Garrett <mjg59@google.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Date:   Thu, 23 Apr 2020 19:51:48 -0400
In-Reply-To: <a47df5af2e2d4bc4bc4757e956c882eb@huawei.com>
References: <a47df5af2e2d4bc4bc4757e956c882eb@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20042323-0012-0000-0000-000003AA27E4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042323-0013-0000-0000-000021E77E23
Message-Id: <1587685908.5610.91.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-23_19:2020-04-23,2020-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004230169
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing Matthew]

Hi Roberto,

On Tue, 2020-04-21 at 10:58 +0000, Roberto Sassu wrote:
> Hi Mimi
> 
> I found a problem in the calculation of the EVM digest.
> 
> If an xattr is in the security domain, vfs_getxattr() calls xattr_getsecurity(),
> which is implemented by LSMs. vfs_getxattr_alloc() instead calls directly
> the filesystem function to read xattrs.
> 
> The problem arises for example when you have a file with a portable
> signature on the correct SELinux label (with \0) and you set security.selinux
> manually:
> 
> setfattr -n security.selinux -v "system_u:object_r:bin_t:s0" cat
> 
> Although the length passed is 26 bytes (without \0), you get:
> 
> # attr -l cat
> Attribute "selinux" has a 27 byte value for cat
> 
> which includes \0.
> 
> From user space, evmctl does not complain (the signature is ok) because
> it calculates the EVM digest with \0, but EVM verification fails (because it
> calculates the digest without \0).
> 
> Should this problem be fixed?

I don't seem to be having any problems verifying the EVM immutable &
portable signatures.  To test, I've copied a properly labeled file
twice, once with the "--preserve=xattr" and once without it.  I signed
the properly labeled file with the EVM immutable & portable signature.
 On the other file, I first set the selinux label before signing it.
If there was a problem manually writing the SELinux label, the
security.evm labels would be different, which they aren't.

Matthew, are you able to reproduce Roberto's problem?

Mimi




