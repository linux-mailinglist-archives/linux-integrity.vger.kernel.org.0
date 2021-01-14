Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949542F58A5
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Jan 2021 04:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbhANCuD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Jan 2021 21:50:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53352 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725888AbhANCuB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Jan 2021 21:50:01 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10E2XHYZ146495;
        Wed, 13 Jan 2021 21:49:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=9xb9gz7S2m6AmBErpV3TLXXY1zLjbE8oW8KfQl8jMyE=;
 b=leJs81loCNuL9ba6PBeJP0bS+zEEKE55O/5CUDY8DRFetzQpNITWvbhgILyZeLm35j7Y
 oQBmyoPWDPiVFnWAM2J1AR8U8hyZe2ezjSR532lzE0lejBqIAQkwQDggfQtKMIQJ5ANP
 YI36IR54OB+F0utkI0aBuMY/cjLxlaFA9bO6cTau6ZyYJsWSBrGAtxVnP46Y0JnDcDLb
 c580aqo8hLL13NkqWWwvUIQG9QqnoZCvhsCtxfXyxXuDNZefqwESaeB4GIXHJ2KukWmL
 kM/Rib8zoes5AIYE/AMN1VUUcY2GcRQCdAoAs9891ae78a/xun//a/3r80ggyZnFxeFK hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 362d890cmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jan 2021 21:49:15 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10E2Yhrf003467;
        Wed, 13 Jan 2021 21:49:15 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 362d890ckt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jan 2021 21:49:15 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10E2n5IL021095;
        Thu, 14 Jan 2021 02:49:13 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 35y448b1e3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jan 2021 02:49:12 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10E2nAY244106238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jan 2021 02:49:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F425AE045;
        Thu, 14 Jan 2021 02:49:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAFE7AE051;
        Thu, 14 Jan 2021 02:49:06 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.57.196])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Jan 2021 02:49:06 +0000 (GMT)
Message-ID: <3746bc7673df25354411151442a7772b867be396.camel@linux.ibm.com>
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
Date:   Wed, 13 Jan 2021 21:49:05 -0500
In-Reply-To: <CAHC9VhTHqwKem=MyQBY4TNAq-DOVhwEZS8pjrSE=4OxdEVm-GA@mail.gmail.com>
References: <20210108040708.8389-1-tusharsu@linux.microsoft.com>
         <20210108040708.8389-9-tusharsu@linux.microsoft.com>
         <CAHC9VhSJk0wG=WzO3bwsueiy19mMi9m6MamTrQfH8C=gXUtvGw@mail.gmail.com>
         <97328fc71687a0e1c327f6821548be9ba35bb193.camel@linux.ibm.com>
         <CAHC9VhTzaQ_q8gJ0oeok_yJ54XLETNvOuhhKnyRwgqsqvpBLCw@mail.gmail.com>
         <71cddb6c8676ccd63c89364d805cfca76d32cb6e.camel@linux.ibm.com>
         <CAHC9VhRhYWEcK7TepZ=LK1m=9Zn_gtOZyAYfamP-TFU3rRH+zw@mail.gmail.com>
         <e29a618645b0e73ec06960a02b6da465614689ff.camel@linux.ibm.com>
         <CAHC9VhTHqwKem=MyQBY4TNAq-DOVhwEZS8pjrSE=4OxdEVm-GA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-13_14:2021-01-13,2021-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101140010
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-01-13 at 21:40 -0500, Paul Moore wrote:
> On Wed, Jan 13, 2021 at 6:11 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Wed, 2021-01-13 at 17:10 -0500, Paul Moore wrote:
> > > On Wed, Jan 13, 2021 at 4:11 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > On Wed, 2021-01-13 at 14:19 -0500, Paul Moore wrote:
> > > > > On Wed, Jan 13, 2021 at 2:13 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > > > On Tue, 2021-01-12 at 11:27 -0500, Paul Moore wrote:
> > > > > > > On Thu, Jan 7, 2021 at 11:07 PM Tushar Sugandhi
> > > > > > > <tusharsu@linux.microsoft.com> wrote:
> > > > > > > > From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> > > > > > > >
> > > > > > > > SELinux stores the active policy in memory, so the changes to this data
> > > > > > > > at runtime would have an impact on the security guarantees provided
> > > > > > > > by SELinux.  Measuring in-memory SELinux policy through IMA subsystem
> > > > > > > > provides a secure way for the attestation service to remotely validate
> > > > > > > > the policy contents at runtime.
> > > > > > > >
> > > > > > > > Measure the hash of the loaded policy by calling the IMA hook
> > > > > > > > ima_measure_critical_data().  Since the size of the loaded policy
> > > > > > > > can be large (several MB), measure the hash of the policy instead of
> > > > > > > > the entire policy to avoid bloating the IMA log entry.
> > > > > > > >
> > > > > > > > To enable SELinux data measurement, the following steps are required:
> > > > > > > >
> > > > > > > > 1, Add "ima_policy=critical_data" to the kernel command line arguments
> > > > > > > >    to enable measuring SELinux data at boot time.
> > > > > > > > For example,
> > > > > > > >   BOOT_IMAGE=/boot/vmlinuz-5.10.0-rc1+ root=UUID=fd643309-a5d2-4ed3-b10d-3c579a5fab2f ro nomodeset security=selinux ima_policy=critical_data
> > > > > > > >
> > > > > > > > 2, Add the following rule to /etc/ima/ima-policy
> > > > > > > >    measure func=CRITICAL_DATA label=selinux
> > > > > > > >
> > > > > > > > Sample measurement of the hash of SELinux policy:
> > > > > > > >
> > > > > > > > To verify the measured data with the current SELinux policy run
> > > > > > > > the following commands and verify the output hash values match.
> > > > > > > >
> > > > > > > >   sha256sum /sys/fs/selinux/policy | cut -d' ' -f 1
> > > > > > > >
> > > > > > > >   grep "selinux-policy-hash" /sys/kernel/security/integrity/ima/ascii_runtime_measurements | tail -1 | cut -d' ' -f 6
> > > > > > > >
> > > > > > > > Note that the actual verification of SELinux policy would require loading
> > > > > > > > the expected policy into an identical kernel on a pristine/known-safe
> > > > > > > > system and run the sha256sum /sys/kernel/selinux/policy there to get
> > > > > > > > the expected hash.
> > > > > > > >
> > > > > > > > Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> > > > > > > > Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > > > > > Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > > > > > > > ---
> > > > > > > >  Documentation/ABI/testing/ima_policy |  3 +-
> > > > > > > >  security/selinux/Makefile            |  2 +
> > > > > > > >  security/selinux/ima.c               | 64 ++++++++++++++++++++++++++++
> > > > > > > >  security/selinux/include/ima.h       | 24 +++++++++++
> > > > > > > >  security/selinux/include/security.h  |  3 +-
> > > > > > > >  security/selinux/ss/services.c       | 64 ++++++++++++++++++++++++----
> > > > > > > >  6 files changed, 149 insertions(+), 11 deletions(-)
> > > > > > > >  create mode 100644 security/selinux/ima.c
> > > > > > > >  create mode 100644 security/selinux/include/ima.h
> > > > > > >
> > > > > > > I remain concerned about the possibility of bypassing a measurement by
> > > > > > > tampering with the time, but I appear to be the only one who is
> > > > > > > worried about this so I'm not going to block this patch on those
> > > > > > > grounds.
> > > > > > >
> > > > > > > Acked-by: Paul Moore <paul@paul-moore.com>
> > > > > >
> > > > > > Thanks, Paul.
> > > > > >
> > > > > > Including any unique string would cause the buffer hash to change,
> > > > > > forcing a new measurement.  Perhaps they were concerned with
> > > > > > overflowing a counter.
> > > > >
> > > > > My understanding is that Lakshmi wanted to force a new measurement
> > > > > each time and felt using a timestamp would be the best way to do that.
> > > > > A counter, even if it wraps, would have a different value each time
> > > > > whereas a timestamp is vulnerable to time adjustments.  While a
> > > > > properly controlled and audited system could be configured and
> > > > > monitored to detect such an event (I *think*), why rely on that if it
> > > > > isn't necessary?
> > > >
> > > > Why are you saying that even if the counter wraps a new measurement is
> > > > guaranteed.   I agree with the rest of what you said.
> > >
> > > I was assuming that the IMA code simply compares the passed
> > > "policy_event_name" value to the previous value, if they are different
> > > a new measurement is taken, if they are the same the measurement
> > > request is ignored.  If this is the case the counter value is only
> > > important in as much as that it is different from the previous value,
> > > even simply toggling a single bit back and forth would suffice in this
> > > case.  IMA doesn't keep a record of every previous "policy_event_name"
> > > value does it?  Am I misunderstanding how
> > > ima_measure_critical_data(...) works?
> >
> > Originally, there was quite a bit of discussion as to how much or how
> > little should be measured for a number of reasons.  One reason is that
> > the TPM is relatively slow.  Another reason is to limit the size of the
> > measurement list.  For this reason, duplicate hashes aren't added to
> > the measurement list or extended into the TPM.
> >
> > When a dentry is removed from cache, its also removed from IMA's iint
> > cache.  A subsequent file read would result in adding the measurement
> > and extending the TPM again.  ima_lookup_digest_entry() is called to
> > prevent adding the duplicate entry.
> >
> > Lakshmi is trying to address the situation where an event changes a
> > value, but then is restored to the original value.  The original and
> > subsequent events are measured, but restoring to the original value
> > isn't re-measured.  This isn't any different than when a file is
> > modified and then reverted.
> >
> > Instead of changing the name like this, which doesn't work for files,
> > allowing duplicate measurements should be generic, based on policy.
> 
> Perhaps it is just the end of the day and I'm a bit tired, but I just
> read all of the above and I have no idea what your current thoughts
> are regarding this patch.

Other than appending the timestamp, which is a hack, the patch is fine.
Support for re-measuring an event can be upstreamed independently.

Mimi

