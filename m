Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC69D3F1A13
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Aug 2021 15:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237068AbhHSNMU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Aug 2021 09:12:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40256 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232821AbhHSNMT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Aug 2021 09:12:19 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17JD7wsX172461;
        Thu, 19 Aug 2021 09:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=dDGjYsd/CVMSln9MLaU3XeTFt8CR0J2fLgNHz0/y9iU=;
 b=Am1bvbllx4lRnvkAwDYBAi4p9ZSpm9z2zER02tQyzSiDhfObeWIw2Bl/i7EibEuNqhWR
 1OhlQdRXhXSORwrb52ryW/U6WjzV83PtIqtUwot1aBh/QqbA/rVslIV7nBd2HWDyLCdQ
 zA7Zvwppso6bjh6vB9q7euEVAhCjkkcfTKnqWaq3HSVvEkiMyybWaf4gKfSZr21mxSqP
 b4zlXs0gNI/h88Pl30Fh6WzkjwaiXy8bF+XyaX0BYJUC3GLXODfcygMS556qhHPdeyN7
 XjZO1bBjDXiQ1LTgA0nkCfNBGsgpYbDAAq0apw2oLiOs01JA6St9v4wUoOF/1fHirOPd LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ahp9x34jb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 09:11:11 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17JD8Cwn173706;
        Thu, 19 Aug 2021 09:11:10 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ahp9x34gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 09:11:10 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17JD2YoE010440;
        Thu, 19 Aug 2021 13:11:07 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3ae53hf6fm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 13:11:07 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17JD7ZVu59507028
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 13:07:35 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2549A4060;
        Thu, 19 Aug 2021 13:11:04 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D11EA405B;
        Thu, 19 Aug 2021 13:11:00 +0000 (GMT)
Received: from sig-9-65-206-165.ibm.com (unknown [9.65.206.165])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 19 Aug 2021 13:10:59 +0000 (GMT)
Message-ID: <f76fcf41728fbdd65f2b3464df0821f248b2cba0.camel@linux.ibm.com>
Subject: Re: [PATCH v4 00/12] Enroll kernel keys thru MOK
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jmorris@namei.org, serge@hallyn.com
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, scott.branden@broadcom.com,
        weiyongjun1@huawei.com, nayna@linux.ibm.com, ebiggers@google.com,
        ardb@kernel.org, nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com, Patrick Uiterwijk <patrick@puiterwijk.org>
Date:   Thu, 19 Aug 2021 09:10:59 -0400
In-Reply-To: <fcb30226f378ef12cd8bd15938f0af0e1a3977a2.camel@kernel.org>
References: <20210819002109.534600-1-eric.snowberg@oracle.com>
         <fcb30226f378ef12cd8bd15938f0af0e1a3977a2.camel@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2wmwyBdw65ZteOoftq2YdC1DS8zGBpNE
X-Proofpoint-GUID: Ti_WZG0CEtbe1hd9y9wFkDYPxk2VybxS
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-19_04:2021-08-17,2021-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108190076
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-08-19 at 14:38 +0300, Jarkko Sakkinen wrote:
> On Wed, 2021-08-18 at 20:20 -0400, Eric Snowberg wrote:
> > Many UEFI Linux distributions boot using shim.  The UEFI shim provides
> > what is called Machine Owner Keys (MOK).  Shim uses both the UEFI Secure
> > Boot DB and MOK keys to validate the next step in the boot chain.  The
> > MOK facility can be used to import user generated keys.  These keys can
> > be used to sign an end-user development kernel build.  When Linux boots,
> > pre-boot keys (both UEFI Secure Boot DB and MOK keys) get loaded in the
> > Linux .platform keyring.  
> > 
> > Currently, pre-boot keys are not trusted within the Linux trust boundary
> > [1]. These platform keys can only be used for kexec. If an end-user
> > wants to use their own key within the Linux trust boundary, they must
> > either compile it into the kernel themselves or use the insert-sys-cert
> > script. Both options present a problem. Many end-users do not want to
> > compile their own kernels. With the insert-sys-cert option, there are
> > missing upstream changes [2].  Also, with the insert-sys-cert option,
> > the end-user must re-sign their kernel again with their own key, and
> > then insert that key into the MOK db. Another problem with
> > insert-sys-cert is that only a single key can be inserted into a
> > compressed kernel.
> > 
> > Having the ability to insert a key into the Linux trust boundary opens
> > up various possibilities.  The end-user can use a pre-built kernel and
> > sign their own kernel modules.  It also opens up the ability for an
> > end-user to more easily use digital signature based IMA-appraisal.  To
> > get a key into the ima keyring, it must be signed by a key within the
> > Linux trust boundary.
> 
> As of today, I can use a prebuilt kernel, crate my own MOK key and sign
> modules. What will be different?

The UEFI db and MOK keys are being loaded onto the .platform keyring,
which is suppose to be limited to verifying the kexec kernel image
signature.  With a downstream patch, kernel modules are being verified
as well.

Initially Patrick Uiterwijk's "[PATCH 0/3] Load keys from TPM2 NV Index
on IMA keyring" patch set attempted to define a new root of trust based
on a key stored in the TPM.  This patch set is similarly attempting to
define a new root of trust based on CA keys stored in the MOK db.

The purpose of this patch set is to define a new, safe trust source
parallel to the builtin keyring, without relying on a downstream patch.
With the new root of trust, the end user could sign his own kernel
modules, sign third party keys, and load keys onto the IMA keyring,
which can be used for signing the IMA policy and other files.

> 
> > Downstream Linux distros try to have a single signed kernel for each
> > architecture.  Each end-user may use this kernel in entirely different
> > ways.  Some downstream kernels have chosen to always trust platform keys
> > within the Linux trust boundary for kernel module signing.  These
> > kernels have no way of using digital signature base IMA appraisal.
> > 
> > This series introduces a new Linux kernel keyring containing the Machine
> > Owner Keys (MOK) called .mok. It also adds a new MOK variable to shim.
> 
> I would name it as ".machine" because it is more "re-usable" name, e.g.
> could be used for similar things as MOK. ".mok" is a bad name because
> it binds directly to a single piece of user space software.

Nayna previously said,
   "I believe the underlying source from where CA keys are loaded might vary 
   based on the architecture (".mok" is UEFI specific.). The key part is 
   that this new keyring should contain only CA keys which can be later 
   used to vouch for user keys loaded onto IMA or secondary keyring at 
   runtime. It would be good to have a "ca" in the name, like .xxxx-ca, 
   where xxxx can be machine, owner, or system. I prefer .system-ca."

The CA keys on the MOK db is simply the first root of trust being
defined, but other roots of trust are sure to follow.  For this reason,
I agree naming the new keyring "mok" should be avoided.

thanks,

Mimi

