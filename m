Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3153BECBA
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 19:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhGGRDZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Jul 2021 13:03:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39122 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230109AbhGGRDY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Jul 2021 13:03:24 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 167GYAbW071343;
        Wed, 7 Jul 2021 13:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=y4UF4OXGjC+VA7opBnaa73FwOsHLASi6BVJbghjovBk=;
 b=XfQ3p0GvrKepLwVpY0vcv5w46CIRrL5qwrhG0YNKgbzs+64q9xoieDfztTVBwUwHjas5
 L1WAIGQjTIG5ZEsKVLWOMhQtThQUKXnpAT1/SUZk8AqgKbSx9OqEdZx2VOgwvuYaqVLd
 GGpFyqNCTuPZJ+X0cK3oGrKVnnAp3ZusXd9NFuSWSGzWNH3nJtOSK+2/TkveAGsYA1uU
 qXFyjNWRO1Kf3PXdgxvXzNqC2qT49IivJa+HI6EVBGUKUNi9IVWM6OtaASQCqirW7fsJ
 lqqqBYwMUEJcNAsho5uG3Zsmfvjvh+4qj/b1giahf/w7ZHEC3Z91/7Z10cgcgf6DPsva zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39m8xu0c3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 13:00:12 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 167GYusb072721;
        Wed, 7 Jul 2021 13:00:12 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39m8xu0c2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 13:00:11 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 167GwOVg012243;
        Wed, 7 Jul 2021 17:00:09 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 39jfh8sunv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 17:00:09 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 167H07br29229360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Jul 2021 17:00:07 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A490A4051;
        Wed,  7 Jul 2021 17:00:07 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 499A7A404D;
        Wed,  7 Jul 2021 17:00:02 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.79.186])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  7 Jul 2021 17:00:02 +0000 (GMT)
Message-ID: <886f30dcf7b3d48644289acc3601c2f0207b19b6.camel@linux.ibm.com>
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
        James Morris <jmorris@namei.org>, serge@hallyn.com,
        keescook@chromium.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, scott.branden@broadcom.com,
        weiyongjun1@huawei.com, nayna@linux.ibm.com, ebiggers@google.com,
        ardb@kernel.org, nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        glin@suse.com, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Date:   Wed, 07 Jul 2021 13:00:01 -0400
In-Reply-To: <5BFB3C52-36D4-47A5-B1B8-977717C555A0@oracle.com>
References: <20210707024403.1083977-1-eric.snowberg@oracle.com>
         <42b787dd3a20fe37c4de60daf75db06e409cfb6d.camel@linux.ibm.com>
         <5BFB3C52-36D4-47A5-B1B8-977717C555A0@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6P45I7PwLPLtRhdK7B4MwaOcI4m1PJ4u
X-Proofpoint-GUID: mSWKaGeURzFKUVTLoQfuySO8Xbm2jkCF
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-07_08:2021-07-06,2021-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107070095
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-07-07 at 10:28 -0600, Eric Snowberg wrote:
> > On Jul 7, 2021, at 6:39 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > On Tue, 2021-07-06 at 22:43 -0400, Eric Snowberg wrote:
> >> This is a follow up to the "Add additional MOK vars" [1] series I 
> >> previously sent.  This series incorporates the feedback given 
> >> both publicly on the mailing list and privately from Mimi. This 
> >> series just focuses on getting end-user keys into the kernel trust 
> >> boundary.
> >> 
> >> Currently, pre-boot keys are not trusted within the Linux boundary [2].
> >> Pre-boot keys include UEFI Secure Boot DB keys and MOKList keys. These
> >> keys are loaded into the platform keyring and can only be used for kexec.
> >> If an end-user wants to use their own key within the Linux trust
> >> boundary, they must either compile it into the kernel themselves or use
> >> the insert-sys-cert script. Both options present a problem. Many
> >> end-users do not want to compile their own kernels. With the
> >> insert-sys-cert option, there are missing upstream changes [3].  Also,
> >> with the insert-sys-cert option, the end-user must re-sign their kernel
> >> again with their own key, and then insert that key into the MOK db.
> >> Another problem with insert-sys-cert is that only a single key can be
> >> inserted into a compressed kernel.
> >> 
> >> Having the ability to insert a key into the Linux trust boundary opens
> >> up various possibilities.  The end-user can use a pre-built kernel and
> >> sign their own kernel modules.  It also opens up the ability for an
> >> end-user to more easily use digital signature based IMA-appraisal.  To
> >> get a key into the ima keyring, it must be signed by a key within the
> >> Linux trust boundary.
> >> 
> >> Downstream Linux distros try to have a single signed kernel for each
> >> architecture.  Each end-user may use this kernel in entirely different
> >> ways.  Some downstream kernels have chosen to always trust platform keys
> >> within the Linux trust boundary for kernel module signing.  These
> >> kernels have no way of using digital signature base IMA appraisal. 
> >> 
> >> This series adds a new MOK variable to shim.  This variable allows the
> >> end-user to decide if they want to trust keys enrolled in the MOK within
> >> the Linux trust boundary.  By default, nothing changes; MOK keys are
> >> not trusted within the Linux kernel.  They are only trusted after the 
> >> end-user makes the decision themselves.  The end-user would set this
> >> through mokutil using a new --trust-mok option [4]. This would work
> >> similar to how the kernel uses MOK variable to enable/disable signature
> >> validation as well as use/ignore the db.
> >> 
> >> When shim boots, it mirrors the new MokTML Boot Services variable to a new
> >> MokListTrustedRT Runtime Services variable and extends PCR14. 
> >> MokListTrustedRT is written without EFI_VARIABLE_NON_VOLATILE set,
> >> preventing an end-user from setting it after booting and doing a kexec.
> >> 
> >> When the kernel boots, if MokListTrustedRT is set and
> >> EFI_VARIABLE_NON_VOLATILE is not set, the MokListRT is loaded into the
> >> secondary trusted keyring instead of the platform keyring. Mimi has
> >> suggested that only CA keys or keys that can be vouched for by other
> >> kernel keys be loaded. All other certs will load into the platform
> >> keyring instead.
> > 
> > Loading MOK CA keys onto the "secondary" keyring would need to be an
> > exception.   Once CA keys are loaded onto the "secondary" keyring,  any
> > certificates signed by those CA keys may be loaded normally, without
> > needing an exception, onto the "secondary" keyring.  The kernel MAY
> > load those keys onto the "secondary" keyring, but really doesn't need
> > to be involved.
> > 
> > Loading ALL of the MOK db keys onto either the "secondary" or
> > "platform" keyrings makes the code a lot more complicated.  Is it
> > really necessary?
> 
> Today all keys are loaded into the platform keyring. For kexec_file_load, 
> the platform and secondary keys are trusted the same.  If this series were 
> not to load them all into either keyring, it would be a kexec_file_load 
> regression, since keys that previously loaded into the platform keyring 
> could be missing. The complexity arises from the CA key restriction.  
> If that requirement was removed, this series would be much smaller.

To prevent the regression, allow the the existing firmware/UEFI keys to
continue to be loaded on the platform keyring, as it is currently being
done.  The new code would load just the MOK db CA keys onto the
secondary keyring, based on the new UEFI variable.  This is the only
code that would require a
"restrict_link_by_builtin_and_secondary_trusted" exemption.  The code
duplication would be minimal in comparison to the complexity being
introduced.

thanks,

Mimi

