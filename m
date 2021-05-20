Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305CF38AE11
	for <lists+linux-integrity@lfdr.de>; Thu, 20 May 2021 14:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbhETMYX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 May 2021 08:24:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35400 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232736AbhETMYJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 May 2021 08:24:09 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14KCDXYO061658;
        Thu, 20 May 2021 08:22:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=IZbN4vqXm8b+HdkSIcyeN9o2mhjmTr8hv3qe5z3P+mA=;
 b=p/4tNJaQmIFoL3SYoCjLQwhGpLHb258cyyqVVgQzwKcr4KZjwpp9hA4/JssSpgSdmLSa
 vzJm1jduZnDkAtNca4VJQmfhut9L2adQNDbHW4HhyaBGrnH5jXB3xk28UFB+OLFFDZ5n
 uTyds56SlJOe2ymO0oWvrb+J5ipzykwp7jMlDm0Xc/8nKIY7Sni9svgqaCC69CHAFIjM
 9TX7Z+IL+IVv/w+ow4kQpHA0zNMRR4/YrMRSVPvALOeOLgDR8aLXlK7eHq+Jo3tjLMrF
 xlISKc1nWn2Z6vlmDSuYqxH0uhazI5QL+tNDhsACWviuKdGZSRby7EUlU5r47TWaPOrT mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38nqk889ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 May 2021 08:22:33 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14KCDSk5061029;
        Thu, 20 May 2021 08:22:33 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38nqk889j7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 May 2021 08:22:32 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14KCHKuG022146;
        Thu, 20 May 2021 12:22:30 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 38j5x8amb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 May 2021 12:22:30 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14KCM0Zw21234144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 12:22:00 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 911BCA4062;
        Thu, 20 May 2021 12:22:28 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3F75A405B;
        Thu, 20 May 2021 12:22:24 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.80.188])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 20 May 2021 12:22:24 +0000 (GMT)
Message-ID: <c134ad45d924e8b719f8abb6d36b426b889e9394.camel@linux.ibm.com>
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
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Date:   Thu, 20 May 2021 08:22:24 -0400
In-Reply-To: <7F861393-7971-43AB-A741-223B8A50FFA0@oracle.com>
References: <20210517225714.498032-1-eric.snowberg@oracle.com>
         <fdb42621e7145ce81a34840cbcf0914874c78913.camel@linux.ibm.com>
         <7F861393-7971-43AB-A741-223B8A50FFA0@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LdGi0352dDnyZBNOXHCG8T7TUW4eOwLf
X-Proofpoint-GUID: d7MQK1BTGmRq8hovTSZeKDT6zxvWKm1c
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-20_03:2021-05-20,2021-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105200093
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-05-19 at 16:04 -0600, Eric Snowberg wrote:
> > On May 19, 2021, at 8:32 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > On Mon, 2021-05-17 at 18:57 -0400, Eric Snowberg wrote:
> >> This series is being sent as an RFC. I am looking for feedback; if
> >> adding additional MOK variables would be an acceptable solution to help
> >> downstream Linux distros solve some of the problems we are facing?
> >> 
> >> Currently, pre-boot keys are not trusted within the Linux boundary [1].
> >> Pre-boot keys include UEFI Secure Boot DB keys and MOKList keys. These
> >> keys are loaded into the platform keyring and can only be used for kexec.
> >> If an end-user wants to use their own key within the Linux trust
> >> boundary, they must either compile it into the kernel themselves or use
> >> the insert-sys-cert script. Both options present a problem. Many
> >> end-users do not want to compile their own kernels. With the
> >> insert-sys-cert option, there are missing upstream changes [2].  Also,
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
> >> within the Linux trust boundary.  In addition, most downstream kernels
> >> do not have an easy way for an end-user to use digital signature based
> >> IMA-appraisal.
> >> 
> >> This series adds two new MOK variables to shim. The first variable
> >> allows the end-user to decide if they want to trust keys contained
> >> within the platform keyring within the Linux trust boundary. By default,
> >> nothing changes; platform keys are not trusted within the Linux kernel.
> >> They are only trusted after the end-user makes the decision themself.
> >> The end-user would set this through mokutil using a new --trust-platform
> >> option [3]. This would work similar to how the kernel uses MOK variables
> >> to enable/disable signature validation as well as use/ignore the db.
> >> 
> >> The second MOK variable allows a downstream Linux distro to make
> >> better use of the IMA architecture specific Secure Boot policy.  This
> >> IMA policy is enabled whenever Secure Boot is enabled.  By default, this 
> >> new MOK variable is not defined.  This causes the IMA architecture 
> >> specific Secure Boot policy to be disabled.  Since this changes the 
> >> current behavior, it is placed behind a new Kconfig option.  Kernels
> >> built with IMA_UEFI_ARCH_POLICY enabled would  allow the end-user
> >> to enable this through mokutil using a new --ima-sb-enable option [3].
> >> This gives the downstream Linux distro the capability to offer the
> >> IMA architecture specific Secure Boot policy option, while giving
> >> the end-user the ability to decide if they want to use it.
> >> 
> >> I have included links to both the mokutil [3] and shim [4] changes I
> >> made to support this new functionality.
> >> 
> >> Thank you and looking forward to hearing your reviews.
> > 
> > This patch set addresses two very different issues - allowing keys on
> > the platform keyring to be trusted for things other than verifying the
> > kexec kernel image signature, overwriting the arch specific IMA secure
> > boot policy rules.  The only common denominator is basing those
> > decisions on UEFI variables, which has been previously suggested and
> > rejected.  The threat model hasn't changed.
> 
> Could you point me please to the previous discussion on the threat model
> this change would violate?  What I found was [1], which I have tried to
> solve with this series.  Having the ability to update a MOK variable 
> indicates the user is not only root, but also the machine owner.  MOK 
> variable updates require both root access to update and then physical 
> presence to set via shim after reboot. This patch set tries to address 
> the "*second* order" Linus requested [2].

The concern is not with the normal way of updating MOK.

> 
> > The desire for allowing a single local CA key to be loaded onto a
> > trusted keyring is understandable.  A local CA key can be used to sign
> > certificates, allowing them to be loaded onto the IMA keyring.  What is
> > the need for multiple keys?
> 
> We have no control over how many keys an end-user may wish to enroll.  
> They might want to enroll a CA for IMA and a different key for their 
> kernel modules. This is a generic kernel that can serve many different 
> purposes. Think distro kernels - like Fedora, Ubuntu, Oracle Linux, etc.

This patch set changes the secondary keyring root of trust, which is
currently the builtin or other keys on the secondary keyring.  My
concern with this change, is that any key on the secondary keyring may
then be directly loaded or used to verify other keys being loaded onto
the IMA keyring.

I really do understand the need for extending the root of trust beyond
the builtin keys and allowing end user keys to be loaded onto a kernel
keyring, but it needs to be done safely.  The first step might include
locally signing the MOK keys being loaded onto the secondary keyring
and then somehow safely providing the local-CA key id to the kernel.

> 
> > Making an exception for using a UEFI key for anything other than
> > verifying the kexec kernel image, can not be based solely on UEFI
> > variables, but should require some form of kernel
> > agreement/confirmation.  
> 
> Isn’t that the case today with how MOK variables get set through
> mokutil and shim? 
> 
> > If/when a safe mechanism for identifying a
> > single local CA key is defined, the certificate should be loaded
> > directly onto the secondary keyring, not linked to the platform
> > keyring.
> > The system owner can enable/disable secure boot.  Disabling the arch
> > secure boot IMA policy rules is not needed.  However, another mechanism
> > for enabling them would be acceptable.
> 
> For a distro kernel, disabling the arch secure boot IMA policy rules is 
> needed.  Distributions build a single kernel that can be used in many 
> different ways. If we wanted to add a built-in IMA policy for an extra 
> level of security protection, this allows the end-user to opt-in when 
> secure boot is enabled. They are then protected before init is called. 
> Not every user will want this protection; a different user may just want 
> secure boot enabled without the IMA level protection.

When secure boot is enabled, the IMA arch policy rules verify the kexec
kernel image is properly signed.  When CONFIG_MODULE_SIG is not
configured, it also verifies kernel modules are properly signed.

> After going through the mailing list history related to IMA appraisal, 
> is this feature strictly geared towards a custom kernel used for a 
> specific purpose?  Do you view it as not being a feature suitable for 
> a generic distribution kernel to offer? 

IMA-appraisal is enabled by distros, but requires labeling the
filesystem with security.ima xattrs, before loading an appraisal
policy.

thanks,

Mimi

> 
> 
> [1] https://lore.kernel.org/lkml/1556221605.24945.3.camel@HansenPartnership.com/
> [2] https://marc.info/?l=linux-kernel&m=136185386310140&w=2
> 
> 


