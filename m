Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2791338E520
	for <lists+linux-integrity@lfdr.de>; Mon, 24 May 2021 13:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbhEXLOI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 May 2021 07:14:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232476AbhEXLOH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 May 2021 07:14:07 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14OB5eD4069183;
        Mon, 24 May 2021 07:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=dxxCUw9AUksxkk1OUxPET1kAJioUlIefAqJ+aPFv2zE=;
 b=Y3rhb2H7qxl7t+aJWPbNDsd1duq2Dr8WOZkMWXrfrCupPFSoskM2khHhKVQfn4tujCOg
 Fosd6oHPNMLFS0FW1tDRTRx8uiRZm8m+6JjmZPhMYNvT/KeAaKs7ceO7ST7qPhPWD8Z0
 Vm79xmzozUQ4ZPAntWpKLDyFYKiOhK3s0YekmuLScpOq6vgdgCNgRMDB+WTlKOxbhWIZ
 80+RYriT3pujuProjU+yvaPie7KppcPKwdu4ZX1LOXnFYibHGp2SyxJCriRmjRUhXmis
 CmYTE/YQx7LQ1G1Zp/5Txn3vTctDioG5bJAOzF7L+C110EWkHk3o+4LvrVyOrZSl8by/ Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38rarr8fm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 May 2021 07:12:12 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14OB5uRo071689;
        Mon, 24 May 2021 07:12:12 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38rarr8fka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 May 2021 07:12:12 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14OB2sjL000786;
        Mon, 24 May 2021 11:12:09 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 38psk88r2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 May 2021 11:12:09 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14OBBcZ823855370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 May 2021 11:11:38 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E5CC5204F;
        Mon, 24 May 2021 11:12:07 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.80.46])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D21705204E;
        Mon, 24 May 2021 11:12:03 +0000 (GMT)
Message-ID: <7a51691adae4099c9d0e1b23e8edf5ce5535eb44.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 0/3] Add additional MOK vars
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        dmitry.kasatkin@gmail.com, James Morris <jmorris@namei.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        torvalds@linux-foundation.org,
        "Serge E . Hallyn" <serge@hallyn.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        pjones@redhat.com, glin@suse.com,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        Patrick Uiterwijk <patrick@puiterwijk.org>
Date:   Mon, 24 May 2021 07:12:02 -0400
In-Reply-To: <7440CE7D-9630-44DB-8916-792523AC86E7@oracle.com>
References: <20210517225714.498032-1-eric.snowberg@oracle.com>
         <fdb42621e7145ce81a34840cbcf0914874c78913.camel@linux.ibm.com>
         <7F861393-7971-43AB-A741-223B8A50FFA0@oracle.com>
         <c134ad45d924e8b719f8abb6d36b426b889e9394.camel@linux.ibm.com>
         <4A887886-BDB2-4F88-9D83-73B9BC9E641F@oracle.com>
         <fd0e91c43cf0dc14aeeda4e7095416c77df0d0cc.camel@linux.ibm.com>
         <7440CE7D-9630-44DB-8916-792523AC86E7@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jJJ4zRQ0UF8b88QIeNQkRd_Dofs6idGR
X-Proofpoint-GUID: uhT95_T61E6kbowOTWesQr_2_eSE1rta
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-24_06:2021-05-24,2021-05-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105240077
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2021-05-23 at 18:57 -0600, Eric Snowberg wrote:
> > On May 21, 2021, at 5:44 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > On Thu, 2021-05-20 at 14:37 -0600, Eric Snowberg wrote:
> >>> On May 20, 2021, at 6:22 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> >>> I really do understand the need for extending the root of trust beyond
> >>> the builtin keys and allowing end user keys to be loaded onto a kernel
> >>> keyring, but it needs to be done safely.  The first step might include
> >>> locally signing the MOK keys being loaded onto the secondary keyring
> >>> and then somehow safely providing the local-CA key id to the kernel.
> >> 
> >> If the machine owner and Linux distributor are independent of one another,
> >> I don’t see how MOK key signing could work.  There wouldn’t be a way for
> >> the kernel to verify the end-user supplied signed MOK key.  An end-user 
> >> choosing a Linux distro is trusting the company/organization building the 
> >> kernel, but the trust doesn’t go the other way.  Do you have a solution 
> >> in mind on how this would be possible? If you do, I’m happy to move in
> >> a different direction to solve this problem.
> > 
> > We are working with the distros to address this problem.  The first
> > attempt at extending the secondary keyring's root of trust relied on a
> > TPM2 NV Index[1].
> 
> Yes, I saw that patch.  I view (which could be a mistake on my part) 
> digital signature based IMA appraisal as an extension of a verified boot. 
> Once a TPM is introduced, it is an extension of a measured boot. It seems 
> like this patch is using measured boot to solve a problem that exists on 
> the verified boot side. While it may be a good solution for someone using 
> both measured boot and verified boot at the same time, not all machines or 
> VMs contain a TPM. 

True, the TPM is used as part of measured boot, but that doesn't
prevent it from being used in other capacities.  In this case the TPM2
NV Index was used just to store a public key and safely used based on
TPM 2.0 rules.

> 
> > Using MOK is a possible alternative, if it can be done safely.
> 
> I do want to point out, in case this was missed, when the new MOK variable 
> is set to trust the platform keyring, PCR14 gets extended [1]. The UEFI BS 
> var MokTPKState is mirrored to a freshly created UEFI RT var called 
> MokTrustPlatform.   The contents are extended into PCR14. This happens every 
> time the system boots. The UEFI RT var does not persist across reboots, it 
> is alway recreated by shim.  The same thing happens with keys in the MOKList.
> Since the contents are mirrored, a key change can be detected on each boot. 
> This makes it possible to use attestation to see if the system was booted 
> with the proper variables set. For someone using measured boot, would this 
> satisfy the requirement of safely protecting the system from a MOK update?

TPM based trusted keys can be sealed to a TPM PCR.  Only if the PCRs
matched, is the private key unsealed.   In that case, measuring
provides the trust for releasing the private key.  In this case, just
measuring the UEFI MOK variable and key does not prevent an unknown
public key from being loaded onto a keyring.   Once loaded it could be
used to verify any signed code's signature.

Mimi

> > For example, if the boot command line could be protected from modification,
> > the end-user could enroll a key in MOK and identify the specific MOK
> > key on the boot command line[2].  The boot command line would then
> > become an additional root of trust source.
> > 
> > The root of trust for loading keys on the different trusted keyrings
> > are self documenting -  restrict_link_by_builtin_trusted,
> > restrict_link_by_builtin_and_secondary_trusted().  A new function would
> > need to be defined to include the boot command line as a new or
> > additional root of trust source.
> 
> 
> [1] https://github.com/esnowberg/shim/commit/ee3961b503e7d39cae7412ddf4e8d6709d998e87#diff-b1dd148baf92edaddd15cc8cd768201114ed86d991502bc492a827c66bbffb69R259
> 

