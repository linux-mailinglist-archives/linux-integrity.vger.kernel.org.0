Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7C238C5F2
	for <lists+linux-integrity@lfdr.de>; Fri, 21 May 2021 13:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbhEULq7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 May 2021 07:46:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14202 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232499AbhEULq4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 May 2021 07:46:56 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14LBYGi7030377;
        Fri, 21 May 2021 07:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=63ZT8sa41e7r+0vT3qTkmsUgDavSFDDoI2d81uQ2iMY=;
 b=L9hSyLAje48wYxW3XW+8ES3yr7V8wd6tVNIGWlhhBKVSzXWQfWbGOrOqdDQAGPc+xF8B
 0TOk2Sj1hFs4U8ngOXS+DBS8VeJXX/KVaT8jESAOqlGnYTb8S191nLdWIry4hA9i+Fcn
 YYT6hUZI7zgDY8x9CohTVg8kwXNCIdAKBRiACkZOYmqWE+/PjQgvDrDZU9U/G6plMPWW
 EEhc2TvDAzupZBGaBAzBi8B1yXf9NM349P9W8A2IqneONV5hiJ+eKrqOW1dntt2Zrkl9
 OACz+sPX1Ka/Yl30N1ohAruJYanL+NDzIiyqpC1sC1wipuif19C0QjQkZLmEkvCZrM1G Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38pbek19e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 May 2021 07:45:02 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14LBYx1u035761;
        Fri, 21 May 2021 07:45:02 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38pbek19da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 May 2021 07:45:02 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14LBS1p1016558;
        Fri, 21 May 2021 11:45:00 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 38j5x8b48p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 May 2021 11:44:59 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14LBiTTG22544752
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 11:44:29 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 608B952050;
        Fri, 21 May 2021 11:44:57 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.6.127])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BB0145204F;
        Fri, 21 May 2021 11:44:53 +0000 (GMT)
Message-ID: <fd0e91c43cf0dc14aeeda4e7095416c77df0d0cc.camel@linux.ibm.com>
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
Date:   Fri, 21 May 2021 07:44:52 -0400
In-Reply-To: <4A887886-BDB2-4F88-9D83-73B9BC9E641F@oracle.com>
References: <20210517225714.498032-1-eric.snowberg@oracle.com>
         <fdb42621e7145ce81a34840cbcf0914874c78913.camel@linux.ibm.com>
         <7F861393-7971-43AB-A741-223B8A50FFA0@oracle.com>
         <c134ad45d924e8b719f8abb6d36b426b889e9394.camel@linux.ibm.com>
         <4A887886-BDB2-4F88-9D83-73B9BC9E641F@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MUe8apbdE6APMT7MJ6YxnSMPparGVqMz
X-Proofpoint-GUID: ZBXZkRp-Z9LqJLD5ntEtu9DO5rW3R11j
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-21_04:2021-05-20,2021-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105210071
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing Patrick Uiterwijk]

On Thu, 2021-05-20 at 14:37 -0600, Eric Snowberg wrote:
> > On May 20, 2021, at 6:22 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:

> > I really do understand the need for extending the root of trust beyond
> > the builtin keys and allowing end user keys to be loaded onto a kernel
> > keyring, but it needs to be done safely.  The first step might include
> > locally signing the MOK keys being loaded onto the secondary keyring
> > and then somehow safely providing the local-CA key id to the kernel.
> 
> If the machine owner and Linux distributor are independent of one another,
> I don’t see how MOK key signing could work.  There wouldn’t be a way for
> the kernel to verify the end-user supplied signed MOK key.  An end-user 
> choosing a Linux distro is trusting the company/organization building the 
> kernel, but the trust doesn’t go the other way.  Do you have a solution 
> in mind on how this would be possible? If you do, I’m happy to move in
> a different direction to solve this problem.

We are working with the distros to address this problem.  The first
attempt at extending the secondary keyring's root of trust relied on a
TPM2 NV Index[1].

Using MOK is a possible alternative, if it can be done safely.  For
example, if the boot command line could be protected from modification,
the end-user could enroll a key in MOK and identify the specific MOK
key on the boot command line[2].  The boot command line would then
become an additional root of trust source.

The root of trust for loading keys on the different trusted keyrings
are self documenting -  restrict_link_by_builtin_trusted,
restrict_link_by_builtin_and_secondary_trusted().  A new function would
need to be defined to include the boot command line as a new or
additional root of trust source.
 
thanks,

Mimi

[1] https://lore.kernel.org/linux-integrity/20210225203229.363302-1-patrick@puiterwijk.org/
[2] Perhaps extend the existing "ca_keys" boot command line option.

