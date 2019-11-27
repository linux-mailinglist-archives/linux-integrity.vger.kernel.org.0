Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6DA10B284
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2019 16:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfK0Pji (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Nov 2019 10:39:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6996 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726655AbfK0Pji (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Nov 2019 10:39:38 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARFbPf2072309
        for <linux-integrity@vger.kernel.org>; Wed, 27 Nov 2019 10:39:36 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2whh5eg2gn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 27 Nov 2019 10:39:36 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 27 Nov 2019 15:39:34 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Nov 2019 15:39:31 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xARFdUPK47251804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Nov 2019 15:39:30 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89BE411C04A;
        Wed, 27 Nov 2019 15:39:30 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5564811C052;
        Wed, 27 Nov 2019 15:39:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.138.180])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 27 Nov 2019 15:39:29 +0000 (GMT)
Subject: Re: One question about trusted key of keyring in Linux kernel.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Zhao, Shirley" <shirley.zhao@intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'Mauro Carvalho Chehab'" <mchehab+samsung@kernel.org>,
        "Zhu, Bing" <bing.zhu@intel.com>,
        "Chen, Luhai" <luhai.chen@intel.com>
Date:   Wed, 27 Nov 2019 10:39:28 -0500
In-Reply-To: <A888B25CD99C1141B7C254171A953E8E490961E5@shsmsx102.ccr.corp.intel.com>
References: <A888B25CD99C1141B7C254171A953E8E49094313@shsmsx102.ccr.corp.intel.com>
         <1573659978.17949.83.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E49095F9B@shsmsx102.ccr.corp.intel.com>
         <1574796456.4793.248.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E490961E5@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112715-0016-0000-0000-000002CD01AF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112715-0017-0000-0000-0000332EE252
Message-Id: <1574869168.4793.282.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_03:2019-11-27,2019-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911270137
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Shirley,

On Wed, 2019-11-27 at 02:46 +0000, Zhao, Shirley wrote:
> Hi, Mimi, 
> 
> Answer your two questions:
> 
> 1. Yes, I have verified trusted key works well without PCR policy
> protection as below: 
> $ keyctl add trusted kmk "new 32 keyhandle=0x81000001" @u
> 1055240928
> $ keyctl list @u
> 1 keys in keyring:
> 1055240928: --alswrv     0     0 trusted: kmk
> $ keyctl pipe 1055240928 > kmk.blob
> $ cat kmk.blob
> 007f0020ff808bd8b7239194e89aac6a95b4d210114742c20afa33493f002dffd068
> 5d510010c12d7ad51eb83d6d93895de066bf3d39718cc503adb4802cb087b88b2fff
> 4b040fe3a2be6a3f87c6749d087c9fb6e8734cb23f438d64087581a13bc83d5dc3b0
> 26e77a894ece6620d0eb85df6449ff3c609fd77d5f0caf79b4535b002e0008000b00
> 0000400000001000209a5b00b0d558fcf9e8c029522715e6b5906366eaec5f34367b
> 8ab16c0fb9009a0073000000000020e3b0c44298fc1c149afbf4c8996fb92427ae41
> e4649b934ca495991b7852b85501000b0022000bdcdb694e102e13a0fba5111081cb
> 6cf616c118d404936cac3e84db24c71e47d50022000b04b5db1aa52635dfb242e76f
> 6bde8e2176ae48fc682946c6c76d96f608079d1f0000002036b6fcca8206c7f722de
> 85821d7ecb4785976fdd642bc7538505a2a818c8a23880214000000100202aedde45
> 08f548d108193ec8fe166a7befde19113fe727ae2b29901bdece96e5
> $ keyctl clear @u
> $ keyctl list @u
> keyring is empty
> $ keyctl add trusted kmk "load `cat kmk.blob` keyhandle=0x81000001"
> @u
> 1022963731
> $ keyctl print 1022963731
> 007f0020ff808bd8b7239194e89aac6a95b4d210114742c20afa33493f002dffd068
> 5d510010c12d7ad51eb83d6d93895de066bf3d39718cc503adb4802cb087b88b2fff
> 4b040fe3a2be6a3f87c6749d087c9fb6e8734cb23f438d64087581a13bc83d5dc3b0
> 26e77a894ece6620d0eb85df6449ff3c609fd77d5f0caf79b4535b002e0008000b00
> 0000400000001000209a5b00b0d558fcf9e8c029522715e6b5906366eaec5f34367b
> 8ab16c0fb9009a0073000000000020e3b0c44298fc1c149afbf4c8996fb92427ae41
> e4649b934ca495991b7852b85501000b0022000bdcdb694e102e13a0fba5111081cb
> 6cf616c118d404936cac3e84db24c71e47d50022000b04b5db1aa52635dfb242e76f
> 6bde8e2176ae48fc682946c6c76d96f608079d1f0000002036b6fcca8206c7f722de
> 85821d7ecb4785976fdd642bc7538505a2a818c8a23880214000000100202aedde45
> 08f548d108193ec8fe166a7befde19113fe727ae2b29901bdece96e5
> 
> 2. The following kernel file is related with this problem. 
> /security/keys/keyctl.c
> /security/keys/key.c
> /security/keys/trusted-keys/trusted_tpm1.c
> /security/keys/trusted-keys/trusted_tpm2.c
> 
> To load the PCR policy protection trusted key, the call stack is: 
> SYSCALL_DEFINE5(add_key,...) --> key_create_or_update() -->
> __key_instantiate_and_link() -->  trusted_instantiate() -->
> tpm2_unseal_trusted() --> tpm2_unseal_cmd(). 
> 
> Check dmesg, there will be error: 
> [73336.351596] trusted_key: key_unseal failed (-1)

Like the other kernel mailing lists, please bottom post.  When
reporting a problem, please include the kernel version and other
relevant details.  For example, the TPM version and type (eg. hardware
vendor, software TPM, etc).  Please indicate if this is a new problem
and which kernel release it first start happening?

I have no experience with the tpm2_ commands,  I suggest trying to
extend a single measurement to a PCR and sealing to that value.

Mimi

