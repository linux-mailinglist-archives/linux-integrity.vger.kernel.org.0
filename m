Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C423C2F585E
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Jan 2021 04:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbhANCSL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Jan 2021 21:18:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34836 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728380AbhAMVNg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Jan 2021 16:13:36 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10DL30Eg133717;
        Wed, 13 Jan 2021 16:11:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=QhuL9Gz2bxSFv4rXqkxZpAJq3ZeRITP9eZdUj9QObPw=;
 b=k1RFcphbsG2oKqUQ+/BhkBZbB/T0zxfrXdrw0CgWrZr2hQ72eCyM4VlQQ9g9hFJ1/KEu
 EfhQWFNmeTZ+Ad5hi6oxxHDXyx66glvQw4WGTSCRs2cjxildWB+9SeI9SnIVbyJpO6Jw
 cYF1iOQLl/bbxyT1jeKq7cqREfu1f8R0DcJGpQVj4AyPcH7tvZIYXLwFA6PtbvV9SMcs
 siArdxDixICILS4WxRdsBNpEaPduGq4ILpajyce6q8z9ug22DE3bgEbcNtCyvXBXmPA+
 TfJq2UiE686tV/Du/nh84Xi1jlyBPv+K0GGdlGbe+XQrjh+mOyAi8+hH8UzSqOQIHIqC Ug== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36284jgmvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jan 2021 16:11:18 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10DL3e7i140759;
        Wed, 13 Jan 2021 16:11:18 -0500
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36284jgmun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jan 2021 16:11:18 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10DL3H72023444;
        Wed, 13 Jan 2021 21:11:16 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 35y448auv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jan 2021 21:11:16 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10DLBEen40632698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jan 2021 21:11:14 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3AF642041;
        Wed, 13 Jan 2021 21:11:13 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74C4A42049;
        Wed, 13 Jan 2021 21:11:10 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.57.196])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Jan 2021 21:11:10 +0000 (GMT)
Message-ID: <71cddb6c8676ccd63c89364d805cfca76d32cb6e.camel@linux.ibm.com>
Subject: Re: [PATCH v10 8/8] selinux: include a consumer of the new IMA
 critical data hook
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, tyhicks@linux.microsoft.com,
        sashal@kernel.org, James Morris <jmorris@namei.org>,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Wed, 13 Jan 2021 16:11:09 -0500
In-Reply-To: <CAHC9VhTzaQ_q8gJ0oeok_yJ54XLETNvOuhhKnyRwgqsqvpBLCw@mail.gmail.com>
References: <20210108040708.8389-1-tusharsu@linux.microsoft.com>
         <20210108040708.8389-9-tusharsu@linux.microsoft.com>
         <CAHC9VhSJk0wG=WzO3bwsueiy19mMi9m6MamTrQfH8C=gXUtvGw@mail.gmail.com>
         <97328fc71687a0e1c327f6821548be9ba35bb193.camel@linux.ibm.com>
         <CAHC9VhTzaQ_q8gJ0oeok_yJ54XLETNvOuhhKnyRwgqsqvpBLCw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-13_11:2021-01-13,2021-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101130124
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-01-13 at 14:19 -0500, Paul Moore wrote:
> On Wed, Jan 13, 2021 at 2:13 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Tue, 2021-01-12 at 11:27 -0500, Paul Moore wrote:
> > > On Thu, Jan 7, 2021 at 11:07 PM Tushar Sugandhi
> > > <tusharsu@linux.microsoft.com> wrote:
> > > > From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> > > >
> > > > SELinux stores the active policy in memory, so the changes to this data
> > > > at runtime would have an impact on the security guarantees provided
> > > > by SELinux.  Measuring in-memory SELinux policy through IMA subsystem
> > > > provides a secure way for the attestation service to remotely validate
> > > > the policy contents at runtime.
> > > >
> > > > Measure the hash of the loaded policy by calling the IMA hook
> > > > ima_measure_critical_data().  Since the size of the loaded policy
> > > > can be large (several MB), measure the hash of the policy instead of
> > > > the entire policy to avoid bloating the IMA log entry.
> > > >
> > > > To enable SELinux data measurement, the following steps are required:
> > > >
> > > > 1, Add "ima_policy=critical_data" to the kernel command line arguments
> > > >    to enable measuring SELinux data at boot time.
> > > > For example,
> > > >   BOOT_IMAGE=/boot/vmlinuz-5.10.0-rc1+ root=UUID=fd643309-a5d2-4ed3-b10d-3c579a5fab2f ro nomodeset security=selinux ima_policy=critical_data
> > > >
> > > > 2, Add the following rule to /etc/ima/ima-policy
> > > >    measure func=CRITICAL_DATA label=selinux
> > > >
> > > > Sample measurement of the hash of SELinux policy:
> > > >
> > > > To verify the measured data with the current SELinux policy run
> > > > the following commands and verify the output hash values match.
> > > >
> > > >   sha256sum /sys/fs/selinux/policy | cut -d' ' -f 1
> > > >
> > > >   grep "selinux-policy-hash" /sys/kernel/security/integrity/ima/ascii_runtime_measurements | tail -1 | cut -d' ' -f 6
> > > >
> > > > Note that the actual verification of SELinux policy would require loading
> > > > the expected policy into an identical kernel on a pristine/known-safe
> > > > system and run the sha256sum /sys/kernel/selinux/policy there to get
> > > > the expected hash.
> > > >
> > > > Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> > > > Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > > > ---
> > > >  Documentation/ABI/testing/ima_policy |  3 +-
> > > >  security/selinux/Makefile            |  2 +
> > > >  security/selinux/ima.c               | 64 ++++++++++++++++++++++++++++
> > > >  security/selinux/include/ima.h       | 24 +++++++++++
> > > >  security/selinux/include/security.h  |  3 +-
> > > >  security/selinux/ss/services.c       | 64 ++++++++++++++++++++++++----
> > > >  6 files changed, 149 insertions(+), 11 deletions(-)
> > > >  create mode 100644 security/selinux/ima.c
> > > >  create mode 100644 security/selinux/include/ima.h
> > >
> > > I remain concerned about the possibility of bypassing a measurement by
> > > tampering with the time, but I appear to be the only one who is
> > > worried about this so I'm not going to block this patch on those
> > > grounds.
> > >
> > > Acked-by: Paul Moore <paul@paul-moore.com>
> >
> > Thanks, Paul.
> >
> > Including any unique string would cause the buffer hash to change,
> > forcing a new measurement.  Perhaps they were concerned with
> > overflowing a counter.
> 
> My understanding is that Lakshmi wanted to force a new measurement
> each time and felt using a timestamp would be the best way to do that.
> A counter, even if it wraps, would have a different value each time
> whereas a timestamp is vulnerable to time adjustments.  While a
> properly controlled and audited system could be configured and
> monitored to detect such an event (I *think*), why rely on that if it
> isn't necessary?

Why are you saying that even if the counter wraps a new measurement is
guaranteed.   I agree with the rest of what you said.

Mimi


