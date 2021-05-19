Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2846B3890FC
	for <lists+linux-integrity@lfdr.de>; Wed, 19 May 2021 16:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241918AbhESOeT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 May 2021 10:34:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240748AbhESOeS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 May 2021 10:34:18 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14JEGqUx130080;
        Wed, 19 May 2021 10:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=y/O3yzKmZ5S/nF30qtkhN4pFKCGjmMbwXJWy7EalH7Y=;
 b=dxLkg4t3xTxmgQ0/oc64iowxGb3YTxZjRh94jqw32U5yrHZStR/2kN+uG3ma+lQ6j257
 zUgscK0rcp/Rph72b9OtmpcwJFa/hEdhE6B7+N6SC/QHLr0pwfIFkO8fn3KwAc1jthBl
 emWGdAbvP1g3voCrGxY6v119KtK0ip4GQwzJ4mh7F1QjMF4W0d7BiGZK6/OSIXUUI4OC
 OfrdM2faa7lZ2OhsQO4fXs9FX6TS+QKYRyFhlAoIYlfshsdE8fAADv0SB+Gkvowl5qgq
 qQibZdrXzljPaPLY1ToODx6zuYjLRoXEubIHLtLHFNS1NwEoFQhawTgURGRimH6KlNOw 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38n4a48f72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 10:32:34 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14JEHhVr131996;
        Wed, 19 May 2021 10:32:34 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38n4a48f62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 10:32:33 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14JEWWBw006834;
        Wed, 19 May 2021 14:32:32 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 38j5jgt634-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 14:32:32 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14JEWT5e31850820
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 14:32:29 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C38DBA4060;
        Wed, 19 May 2021 14:32:29 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDF2DA4064;
        Wed, 19 May 2021 14:32:26 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.6.141])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 May 2021 14:32:26 +0000 (GMT)
Message-ID: <fdb42621e7145ce81a34840cbcf0914874c78913.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 0/3] Add additional MOK vars
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, jarkko@kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        torvalds@linux-foundation.org, serge@hallyn.com,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        glin@suse.com
Date:   Wed, 19 May 2021 10:32:26 -0400
In-Reply-To: <20210517225714.498032-1-eric.snowberg@oracle.com>
References: <20210517225714.498032-1-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Uz0m6BshD-Whk-r4KS0C61M6yjtaS8ZK
X-Proofpoint-GUID: Dvfcj28MJQ7usNP2HwRzr5tcZDczTIye
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-19_06:2021-05-19,2021-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 mlxscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105190084
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Eric,

On Mon, 2021-05-17 at 18:57 -0400, Eric Snowberg wrote:
> This series is being sent as an RFC. I am looking for feedback; if
> adding additional MOK variables would be an acceptable solution to help
> downstream Linux distros solve some of the problems we are facing?
> 
> Currently, pre-boot keys are not trusted within the Linux boundary [1].
> Pre-boot keys include UEFI Secure Boot DB keys and MOKList keys. These
> keys are loaded into the platform keyring and can only be used for kexec.
> If an end-user wants to use their own key within the Linux trust
> boundary, they must either compile it into the kernel themselves or use
> the insert-sys-cert script. Both options present a problem. Many
> end-users do not want to compile their own kernels. With the
> insert-sys-cert option, there are missing upstream changes [2].  Also,
> with the insert-sys-cert option, the end-user must re-sign their kernel
> again with their own key, and then insert that key into the MOK db.
> Another problem with insert-sys-cert is that only a single key can be
> inserted into a compressed kernel.
> 
> Having the ability to insert a key into the Linux trust boundary opens
> up various possibilities.  The end-user can use a pre-built kernel and
> sign their own kernel modules.  It also opens up the ability for an
> end-user to more easily use digital signature based IMA-appraisal.  To
> get a key into the ima keyring, it must be signed by a key within the
> Linux trust boundary.
> 
> Downstream Linux distros try to have a single signed kernel for each
> architecture.  Each end-user may use this kernel in entirely different
> ways.  Some downstream kernels have chosen to always trust platform keys
> within the Linux trust boundary.  In addition, most downstream kernels
> do not have an easy way for an end-user to use digital signature based
> IMA-appraisal.
> 
> This series adds two new MOK variables to shim. The first variable
> allows the end-user to decide if they want to trust keys contained
> within the platform keyring within the Linux trust boundary. By default,
> nothing changes; platform keys are not trusted within the Linux kernel.
> They are only trusted after the end-user makes the decision themself.
> The end-user would set this through mokutil using a new --trust-platform
> option [3]. This would work similar to how the kernel uses MOK variables
> to enable/disable signature validation as well as use/ignore the db.
> 
> The second MOK variable allows a downstream Linux distro to make
> better use of the IMA architecture specific Secure Boot policy.  This
> IMA policy is enabled whenever Secure Boot is enabled.  By default, this 
> new MOK variable is not defined.  This causes the IMA architecture 
> specific Secure Boot policy to be disabled.  Since this changes the 
> current behavior, it is placed behind a new Kconfig option.  Kernels
> built with IMA_UEFI_ARCH_POLICY enabled would  allow the end-user
> to enable this through mokutil using a new --ima-sb-enable option [3].
> This gives the downstream Linux distro the capability to offer the
> IMA architecture specific Secure Boot policy option, while giving
> the end-user the ability to decide if they want to use it.
> 
> I have included links to both the mokutil [3] and shim [4] changes I
> made to support this new functionality.
> 
> Thank you and looking forward to hearing your reviews.

This patch set addresses two very different issues - allowing keys on
the platform keyring to be trusted for things other than verifying the
kexec kernel image signature, overwriting the arch specific IMA secure
boot policy rules.  The only common denominator is basing those
decisions on UEFI variables, which has been previously suggested and
rejected.  The threat model hasn't changed.

The desire for allowing a single local CA key to be loaded onto a
trusted keyring is understandable.  A local CA key can be used to sign
certificates, allowing them to be loaded onto the IMA keyring.  What is
the need for multiple keys? 

Making an exception for using a UEFI key for anything other than
verifying the kexec kernel image, can not be based solely on UEFI
variables, but should require some form of kernel
agreement/confirmation.  If/when a safe mechanism for identifying a
single local CA key is defined, the certificate should be loaded
directly onto the secondary keyring, not linked to the platform
keyring.

The system owner can enable/disable secure boot.  Disabling the arch
secure boot IMA policy rules is not needed.  However, another mechanism
for enabling them would be acceptable.

thanks,

Mimi

