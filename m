Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA09910F57F
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Dec 2019 04:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfLCDMO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Dec 2019 22:12:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8620 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726186AbfLCDMO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Dec 2019 22:12:14 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB338fJu039177;
        Mon, 2 Dec 2019 22:12:10 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wm6snqf1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Dec 2019 22:12:10 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xB33BRZO029645;
        Tue, 3 Dec 2019 03:12:09 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04dal.us.ibm.com with ESMTP id 2wkg26pg31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Dec 2019 03:12:09 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB33C7AZ32964986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Dec 2019 03:12:07 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4D54136055;
        Tue,  3 Dec 2019 03:12:07 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67F9B136051;
        Tue,  3 Dec 2019 03:12:05 +0000 (GMT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.80.221.34])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  3 Dec 2019 03:12:05 +0000 (GMT)
Message-ID: <1575342724.24227.41.camel@linux.ibm.com>
Subject: Re: One question about trusted key of keyring in Linux kernel.
From:   James Bottomley <jejb@linux.ibm.com>
To:     "Zhao, Shirley" <shirley.zhao@intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'Mauro Carvalho Chehab'" <mchehab+samsung@kernel.org>,
        "Zhu, Bing" <bing.zhu@intel.com>,
        "Chen, Luhai" <luhai.chen@intel.com>
Date:   Mon, 02 Dec 2019 19:12:04 -0800
In-Reply-To: <A888B25CD99C1141B7C254171A953E8E4909E62E@shsmsx102.ccr.corp.intel.com>
References: <A888B25CD99C1141B7C254171A953E8E49094313@shsmsx102.ccr.corp.intel.com>
         <1573659978.17949.83.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E49095F9B@shsmsx102.ccr.corp.intel.com>
         <1574877977.3551.5.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E49096521@shsmsx102.ccr.corp.intel.com>
         <1575057916.6220.7.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E4909BA3B@shsmsx102.ccr.corp.intel.com>
         <1575260220.4080.17.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E4909D360@shsmsx102.ccr.corp.intel.com>
         <1575267453.4080.26.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E4909E381@shsmsx102.ccr.corp.intel.com>
         <1575269075.4080.31.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E4909E399@shsmsx102.ccr.corp.intel.com>
         <1575312932.24227.13.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E4909E62E@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_06:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912030028
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-12-03 at 02:11 +0000, Zhao, Shirley wrote:
> Thanks so much for you feedback, James. 
> And glad to hear that the API will be made more friendly. 
> 
> But I have a little confused about the call stack. 
> From the document, https://github.com/torvalds/linux/blob/master/Docu
> mentation/security/keys/trusted-encrypted.rst and 
> https://github.com/zfsonlinux/dracut/tree/master/modules.d/97masterke
> y, the trusted key is a random number and generated by TPM2.0 and
> sealed with TPM2.0 2048 RSA key. 

Well, um, that document seems to be based on TPM 1.2 ... a lot of what
it says isn't quite true for TPM 2.0.  For instance all TPM 2.0 primary
keys come with a symmetric component, so the sealed data in TPM 2.0 is
actually symmetrically encrypted to a primary key.

> The 2048 RSA key is generated by tpm2_createprimary, and it can be
> got by the TPM2.0 handle, just the "keyhandle" used in the following
> keyctl command. 
> $ keyctl add trusted kmk "new 32 keyhandle=0x81000001 hash=sha256
> policydigest=`cat pcr7.policy`" @u

The problem TPM 2.0 has is that most of them can't generate prime
numbers very fast, so even through the kernel could generate the RSA
primary, it would usually take far too long, so if you want to use a
RSA primary you have to pre-generate one and place it in NV storage;
the TCG recommends doing this at handle 81000001, which is what you
have above.  However, the more modern way is to derive an elliptic
curve key primary key every time ... EC keys can be generated by most
TPMs in 10s of milliseconds, so the primary doesn't need to be present
in NVRAM.

THe kernel should be using the EC primary method for the parent.  The
only exception is when the key has an intermediate parent, and then it
can be simply loaded from a file.

> If reboot, to re-load the trusted key back to keyring, just call
> tpm2_unseal is enough, don't need to call tpm2_load to load the
> TPM2.0 2048 RSA key.
> If the trusted key is also protected by policy, then the policy will
> be checked during tpm2_unseal. 
> 
> After check the source code, the call stack is mostly like: 
> SYSCALL_DEFINE5(add_key,...) --> key_create_or_update() -->
> __key_instantiate_and_link() -->  trusted_instantiate() -->
> tpm2_unseal_trusted() --> tpm2_unseal_cmd().

Well, the API is confusing, but the code seems to imply the parent
should be present somehow.  A key in NVRAM, like 81000001 is always
present so it doesn't need to be loaded it can just be used as is.

> Another problem here is, to build the policy to unseal the key, it
> need to start an policy session, and transfer the session handle to
> TPM2.0 unseal command. 
> In my keyctl command, I use tpm2.0 command to start the session and
> get the handle, put it into the keyctl command like:
> keyctl add trusted kmk "load `cat kmk.blob` keyhandle=0x81000001
> policyhandle=0x3000000" @u

As I said, using policy handles simply won't scale, so we need to use
the actual policy instead ... thus the policy should be passed into the
kernel  as part of the trusted key and the kernel itself would generate
a policy session from the policy statements ... this approach is aready
proven to be useful and functional in the tpm2 openssl engine code.

James

