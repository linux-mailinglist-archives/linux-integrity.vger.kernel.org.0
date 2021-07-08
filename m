Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC7D3C14BF
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Jul 2021 15:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhGHOAO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Jul 2021 10:00:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231485AbhGHOAO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Jul 2021 10:00:14 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 168DXd3u144912;
        Thu, 8 Jul 2021 09:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=+clPLLZTo0GHr3TARtG5M+niMrD2xIYIzfX7kUTjkM4=;
 b=kMv8e2ZYgwr9SIXWvJ4yENSF9HYztbBIqpH0y4dJLXtiPkIcRzrPd5cxUTPRrQcPHCXN
 rajwlpS52+/ep3Smksijnsmg5ip2nQ4euk0XjddVvrzr7yfw7AzSNzToI6sfeFsLlblu
 yk3d89OAqbhqfnh5kb9a1BsUjqZh0x4By97SYk7M8E7nsd/ZMAvCIQx4OYZwRnNTTXzv
 DUPeJBe4Czjgr5lc7rBveiLRJFmbVD4qk9m20Q8m6+wJyWWMtTpLBZ/Z22ra9jDWrCKR
 KOBBsReA83xUTeFLeIdGuyPsfRZJX4bKPgnXZGiuc6aIEM6+pANL52DVAFZgBlrO5RPA og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39nhcb41qn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 09:56:55 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 168DXgaB145241;
        Thu, 8 Jul 2021 09:56:54 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39nhcb41pa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 09:56:54 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 168DpgeH008469;
        Thu, 8 Jul 2021 13:56:51 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 39jf5ha84w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 13:56:51 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 168Dunrj36110806
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Jul 2021 13:56:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16E88A405B;
        Thu,  8 Jul 2021 13:56:49 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B222A405E;
        Thu,  8 Jul 2021 13:56:44 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.92.57])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  8 Jul 2021 13:56:43 +0000 (GMT)
Message-ID: <c0cf7f883a9252c17427f1f992e4973e78481304.camel@linux.ibm.com>
Subject: Re: [PATCH RFC 00/12] Enroll kernel keys thru MOK
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        glin@suse.com, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Date:   Thu, 08 Jul 2021 09:56:43 -0400
In-Reply-To: <D34A6328-91CA-4E1E-845C-FAC9B424819B@oracle.com>
References: <20210707024403.1083977-1-eric.snowberg@oracle.com>
         <42b787dd3a20fe37c4de60daf75db06e409cfb6d.camel@linux.ibm.com>
         <5BFB3C52-36D4-47A5-B1B8-977717C555A0@oracle.com>
         <886f30dcf7b3d48644289acc3601c2f0207b19b6.camel@linux.ibm.com>
         <D34A6328-91CA-4E1E-845C-FAC9B424819B@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Rmx51EWYKw7nv6rYbZhkVfqnBL1ggZE-
X-Proofpoint-GUID: e8qQ2TfThkgAUAEfda4mMDwXmCLDzy_F
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-08_06:2021-07-08,2021-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107080074
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-07-07 at 16:10 -0600, Eric Snowberg wrote:
> > On Jul 7, 2021, at 11:00 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > On Wed, 2021-07-07 at 10:28 -0600, Eric Snowberg wrote:
> >>> On Jul 7, 2021, at 6:39 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >>> 
> >>> On Tue, 2021-07-06 at 22:43 -0400, Eric Snowberg wrote:
> >>>> This is a follow up to the "Add additional MOK vars" [1] series I 
> >>>> previously sent.  This series incorporates the feedback given 
> >>>> both publicly on the mailing list and privately from Mimi. This 
> >>>> series just focuses on getting end-user keys into the kernel trust 
> >>>> boundary.
> >>>> 
> >>>> Currently, pre-boot keys are not trusted within the Linux boundary [2].
> >>>> Pre-boot keys include UEFI Secure Boot DB keys and MOKList keys. These
> >>>> keys are loaded into the platform keyring and can only be used for kexec.
> >>>> If an end-user wants to use their own key within the Linux trust
> >>>> boundary, they must either compile it into the kernel themselves or use
> >>>> the insert-sys-cert script. Both options present a problem. Many
> >>>> end-users do not want to compile their own kernels. With the
> >>>> insert-sys-cert option, there are missing upstream changes [3].  Also,
> >>>> with the insert-sys-cert option, the end-user must re-sign their kernel
> >>>> again with their own key, and then insert that key into the MOK db.
> >>>> Another problem with insert-sys-cert is that only a single key can be
> >>>> inserted into a compressed kernel.
> >>>> 
> >>>> Having the ability to insert a key into the Linux trust boundary opens
> >>>> up various possibilities.  The end-user can use a pre-built kernel and
> >>>> sign their own kernel modules.  It also opens up the ability for an
> >>>> end-user to more easily use digital signature based IMA-appraisal.  To
> >>>> get a key into the ima keyring, it must be signed by a key within the
> >>>> Linux trust boundary.
> >>>> 
> >>>> Downstream Linux distros try to have a single signed kernel for each
> >>>> architecture.  Each end-user may use this kernel in entirely different
> >>>> ways.  Some downstream kernels have chosen to always trust platform keys
> >>>> within the Linux trust boundary for kernel module signing.  These
> >>>> kernels have no way of using digital signature base IMA appraisal. 
> >>>> 
> >>>> This series adds a new MOK variable to shim.  This variable allows the
> >>>> end-user to decide if they want to trust keys enrolled in the MOK within
> >>>> the Linux trust boundary.  By default, nothing changes; MOK keys are
> >>>> not trusted within the Linux kernel.  They are only trusted after the 
> >>>> end-user makes the decision themselves.  The end-user would set this
> >>>> through mokutil using a new --trust-mok option [4]. This would work
> >>>> similar to how the kernel uses MOK variable to enable/disable signature
> >>>> validation as well as use/ignore the db.
> >>>> 
> >>>> When shim boots, it mirrors the new MokTML Boot Services variable to a new
> >>>> MokListTrustedRT Runtime Services variable and extends PCR14. 
> >>>> MokListTrustedRT is written without EFI_VARIABLE_NON_VOLATILE set,
> >>>> preventing an end-user from setting it after booting and doing a kexec.
> >>>> 
> >>>> When the kernel boots, if MokListTrustedRT is set and
> >>>> EFI_VARIABLE_NON_VOLATILE is not set, the MokListRT is loaded into the
> >>>> secondary trusted keyring instead of the platform keyring. Mimi has
> >>>> suggested that only CA keys or keys that can be vouched for by other
> >>>> kernel keys be loaded. All other certs will load into the platform
> >>>> keyring instead.
> >>> 
> >>> Loading MOK CA keys onto the "secondary" keyring would need to be an
> >>> exception.   Once CA keys are loaded onto the "secondary" keyring,  any
> >>> certificates signed by those CA keys may be loaded normally, without
> >>> needing an exception, onto the "secondary" keyring.  The kernel MAY
> >>> load those keys onto the "secondary" keyring, but really doesn't need
> >>> to be involved.
> >>> 
> >>> Loading ALL of the MOK db keys onto either the "secondary" or
> >>> "platform" keyrings makes the code a lot more complicated.  Is it
> >>> really necessary?
> >> 
> >> Today all keys are loaded into the platform keyring. For kexec_file_load, 
> >> the platform and secondary keys are trusted the same.  If this series were 
> >> not to load them all into either keyring, it would be a kexec_file_load 
> >> regression, since keys that previously loaded into the platform keyring 
> >> could be missing. The complexity arises from the CA key restriction.  
> >> If that requirement was removed, this series would be much smaller.
> > 
> > To prevent the regression, allow the the existing firmware/UEFI keys to
> > continue to be loaded on the platform keyring, as it is currently being
> > done.  The new code would load just the MOK db CA keys onto the
> > secondary keyring, based on the new UEFI variable.  This is the only
> > code that would require a
> > "restrict_link_by_builtin_and_secondary_trusted" exemption.  The code
> > duplication would be minimal in comparison to the complexity being
> > introduced.
> 
> This series was written with the following three requirements in mind:
> 
> 1. Only CA keys that were originally bound for the platform keyring 
> can enter the secondary keyring.
> 
> 2. No key in the UEFI Secure Boot DB, CA or not, may enter the 
> secondary keyring, only MOKList keys may be trusted.
> 
> 3. A new MOK variable is added to signify the user wants to trust 
> MOKList keys.

Sounds good!

> 
> Given these requirements, I started down the path I think you are 
> suggesting.  However I found it to be more complex.  If we load all 
> keys into the platform keyring first and later try to load only CA keys, 
> we don’t have a way of knowing where the platform key came from.  
> Platform keys can originate from the UEFI Secure Boot DB or the MOKList. 
> This would violate the second requirement. This caused me to need to 
> create a new keyring handler. [PATCH RFC 10/12] integrity: add new 
> keyring handler.

To prevent the regression you mentioned, I was suggesting reading the
MOK DB twice.  One time loading all the keys onto the platform keyring.
The other time loading only the CA keys onto the secondary keyring.

> 
> To satisfy the first requirement a new restriction is required.  This 
> is contained in [PATCH RFC 03/12] KEYS: CA link restriction.
> 
> To satisfy the third requirement, we must read the new MOK var.  This 
> is contained in [PATCH RFC 06/12] integrity: Trust mok keys if 
> MokListTrustedRT found.
> 
> The patches above make up a majority of the new code.  
> 
> The remaining code of creating a new .mok keyring was done with code 
> reuse in mind. Many of the required functions necessary to add this 
> capability is already contained in integrity_ functions.  If the 
> operation was done directly on the secondary keyring, similar code 
> would need to be added to certs/system_keyring.c. Just like how the 
> platform keyring is created within integrity code, the mok keyring 
> is created in the same fashion.  When the platform keyring has 
> completed initialization and loaded all its keys, the keyring is set 
> into system_keyring code using set_platform_trusted_keys.  Instead of 
> setting the mok keyring, I’m moving the keys directly into the secondary 
> keyring, while bypassing the current restriction placed on this keyring.
> Basically I'm trying to follow the same design pattern. 
> 
> If requirements #1, #2 or both (#1 and #2) could be dropped, most of 
> this series would not be necessary.

But without these requirements, the source of trust is unclear.

Is there a reason why the MOK keyring is temporary?   Asumming a
function similar to "restrict_link_by_builtin_and_secondary_trusted" is
defined to include the MOK keyring, the CA keys in the MOK db would be
loaded onto the MOK keyring, the other keys that meet the secondary
keyring restriction would be loaded directly onto the secondary
keyring[1], and as you currently have, the remaining keys onto the
platform keyring.

This eliminates the exemption needed for loading keys onto the
secondary keyring.  The MOK keyring, containing just CA keys, becomes a
new trust source.

thanks,

Mimi

[1] Refer to the comment in
restrict_link_by_builtin_and_secondary_trusted() on linking the builtin
keyring to the secondary keyring.

