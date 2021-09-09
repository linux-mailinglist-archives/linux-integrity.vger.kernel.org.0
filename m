Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8533C405621
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Sep 2021 15:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356258AbhIINSK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Sep 2021 09:18:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10226 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357700AbhIINEd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Sep 2021 09:04:33 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 189CbkCV105296;
        Thu, 9 Sep 2021 09:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=OhUvz1rIDq/zvu3gfwCdqIy5HpuMtMsqaNS5AaNDY5Q=;
 b=YgVGRBvnnz94nX/tfynK/rLc6efTmYsqazPpQx3Q9AuTyv+TjRiOcTwYh3kunq37gM67
 gJLGyB8xAxnaqE2JqFvUB1CNu5uYUweAoCIRdHyqoFpr0fgugnR6A5QHmFrwlcIaJ3Gi
 GaOZ0YpoS5I6UKTS1sMWX1qGVWHG/Gp6pmPYtFkvdrRTz51KWqv29WeXTrvy1EOg2efm
 mI6BRZsjsLM6V4ifz6AQagxrVrQAlbiUBwamEUIu45kh70ExJVLnvdnGLI745kO6Cr4N
 lxaMEW0wNo6Es6IAMt6n3ClqvsaNDXcTlh0afejGnxo/88TEYOZvML1ky2s2r7WcV6Uv FA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ayh0pjr8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 09:02:51 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 189CpeMa164946;
        Thu, 9 Sep 2021 09:02:50 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ayh0pjr6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 09:02:49 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 189CvMtv019188;
        Thu, 9 Sep 2021 13:02:47 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3axcnnww0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 13:02:47 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 189D2hLJ45351198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Sep 2021 13:02:44 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA0ADA406E;
        Thu,  9 Sep 2021 13:02:43 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF7F0A406D;
        Thu,  9 Sep 2021 13:02:38 +0000 (GMT)
Received: from sig-9-65-72-231.ibm.com (unknown [9.65.72.231])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Sep 2021 13:02:38 +0000 (GMT)
Message-ID: <96262181e8e94638866fb63caff58cce97c3dbf6.camel@linux.ibm.com>
Subject: Re: [PATCH v5 00/12] Enroll kernel keys thru MOK
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        lszubowi@redhat.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        pjones@redhat.com,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Date:   Thu, 09 Sep 2021 09:02:38 -0400
In-Reply-To: <3685CAB2-43EB-47BA-80E8-C830D3339458@oracle.com>
References: <20210907160110.2699645-1-eric.snowberg@oracle.com>
         <7f9fb65a4ee20c337646a1fc887cd24365c2c59e.camel@kernel.org>
         <b44726f2d71960d53b4860ccab71f02186295da9.camel@kernel.org>
         <3685CAB2-43EB-47BA-80E8-C830D3339458@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: J1WBI8Sks0uyNDryCPgXY9F7m_x_uUQI
X-Proofpoint-ORIG-GUID: Gg-7vQDukxKaWuD0bo7cP0Yfpq77aDrk
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-09_04:2021-09-09,2021-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109090076
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-09-08 at 16:25 -0600, Eric Snowberg wrote:
> > On Sep 8, 2021, at 10:49 AM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > 
> > On Wed, 2021-09-08 at 19:03 +0300, Jarkko Sakkinen wrote:
> >> 
> >>> Downstream Linux distros try to have a single signed kernel for each
> >>> architecture.  Each end-user may use this kernel in entirely different
> >>> ways.  Some downstream kernels have chosen to always trust platform keys
> >>> within the Linux trust boundary for kernel module signing.  These
> >>> kernels have no way of using digital signature base IMA appraisal.
> >>> 
> >>> This series introduces a new Linux kernel keyring containing the Machine
> >>> Owner Keys (MOK) called .machine. It also adds a new MOK variable to shim.
> >>> This variable allows the end-user to decide if they want to trust keys
> >>> enrolled in the MOK within the Linux trust boundary.  By default,
> >>> nothing changes; MOK keys are not trusted within the Linux kernel.  They
> >>> are only trusted after the end-user makes the decision themselves.  The
> >>> end-user would set this through mokutil using a new --trust-mok option
> >>> [3]. This would work similar to how the kernel uses MOK variables to
> >>> enable/disable signature validation as well as use/ignore the db.
> >> 
> >> OK, changes are described here (again speaking about trusting tho). The
> >> motivation part is missing. The text before this is more like confusion
> >> part. When you describe motivation to do something you should really be in
> >> grass roots, e.g. "when you have this feature in the kernel, look, I can
> >> do now this". It's not that hard. E.g. with an usage example it is quite
> >> quick accomplish this.
> > 
> > The code changes overally make sense but this motivotional part is the
> > problem. E.g. if you do a pull request, it is completely *unusable* in
> > that context. In that case I would have to write something that should
> > have been the cover letter. It's 12 patches, so it is perfectly sensible
> > to ask a better one.
> 
> Would this be a more appropriate cover letter that includes a better
> motivation?
> 
> Back in 2013 Linus requested a feature to allow end-users to have the 
> ability "to add their own keys and sign modules they trust".  This was his 
> *second* order outlined here [1].  There have been many attempts over the
> years to solve this problem, all have been rejected.  Many distributions 
> carry one of these rejected attempts. This series tries to solve this problem 
> with a solution that takes into account all the problems brought up in the 
> previous attempts.

Instead of making the reviewer look up the failed attempts, please
summarize why they failed (e.g. all preboot firmware keys were
trusted), and then continue, like below, with how this attempt differs.

> 
> This series introduces a new Linux kernel keyring containing the Machine
> Owner Keys (MOK) called .machine.

Other archs will also want to allow loading "end-users" key.  Please
prefix this paragraph with something like "On UEFI based systems".

>  It also adds a new MOK variable to shim.

Replace "adds" with "defines".

> This variable allows the end-user to decide if they want to load keys
> enrolled in the MOK within the Linux kernel.  By default, nothing changes; 
> MOK keys are not loaded within the Linux kernel.  They are only loaded after
> the end-user makes the decision themselves.  The end-user would set this 
> through mokutil using a new --trust-mok option [2]. This would work similar 
> to how the kernel uses MOK variables to enable/disable signature validation 
> as well as use/ignore the db. Mimi has suggested that only CA keys be loaded 
> into this keyring. All other certs will load into the platform keyring instead.

Thank you for crediting me for limiting loading only the CA keys stored
in the MOK db onto the "machine" keyring, but the limitation should be
better integrated in the paragraph.

> Secure Boot keys will never be loaded.  They will always be loaded into
> the platform keyring.  If an end-user wanted to load one, they would
> need to enroll it into the MOK.
> 
> Steps required by the end user:
> 
> Sign kernel module with user created key:
> $ /usr/src/kernels/$(uname -r)/scripts/sign-file sha512 signing_key.priv \
>     signing_key.x509 my_module.ko
> 
> Import the key into the MOK
> $ mokutil --import signing_key.x509

To differentiate this "signing_key" from others, perhaps name the file
"machine_sigining_key" or "local_signing_key".

thanks,

Mimi

> 
> Setup the kernel to load MOK keys into the .machine keyring
> $ mokutil —trust-mok
> 
> Then reboot, the MokManager will load and ask if you want to trust the MOK 
> key and enroll the MOK into the MOKList.  Afterwards the signed kernel module 
> will load.
> 
> I have included links to both the mokutil [2] and shim [3] changes I
> have made to support this new functionality.
> 
> [1] https://marc.info/?l=linux-kernel&m=136185386310140&w=2
> [2] https://github.com/esnowberg/mokutil/tree/0.3.0-mokvars-v2
> [3] https://github.com/esnowberg/shim/tree/mokvars-v2


