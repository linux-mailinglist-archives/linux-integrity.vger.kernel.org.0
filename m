Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4524A2F5328
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Jan 2021 20:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbhAMTOE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Jan 2021 14:14:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35406 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728342AbhAMTOE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Jan 2021 14:14:04 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10DJ40hL023091;
        Wed, 13 Jan 2021 14:13:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=UgbKyq3svagQP3GWE+YW1JMEuFfG+Iz06Izeuxq7Olg=;
 b=CzSk14SLXMCNXX2UiemQ2asuaxCGfQovLULtcDRb8CpT3z2NuhpW686BbTV9QDvZ3fAF
 +Rtz5p3z91K1OmfBBYnFsZz+2VvlTSZsIQA5pstZKtoc6cCWKJDcSuVzVFF7Vq269mYj
 xxxUT+2PrXU1xotOscJjFfLetEftyOl2p5FuRx+m52GxUY4c50cPyvpWNIFPhnc8cRU5
 JAl7hbRFEJ6M3GRrOgU7tFK5DOPnfX9rNqxpH07XZEvGEO+nnDJcC0OpIBYrb6LIFivI
 HL0RN9Jp+GNzyVbYLrqntsjm/u8vhAdPu37D/tQWSlGTuaWKRkLXYeCBPDtmUyirk4rz Wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3625sma2u6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jan 2021 14:13:18 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10DJ5kJ9031631;
        Wed, 13 Jan 2021 14:13:18 -0500
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3625sma2t6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jan 2021 14:13:18 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10DJDF5n007953;
        Wed, 13 Jan 2021 19:13:15 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 35y448jsxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jan 2021 19:13:15 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10DJD8Hk23658956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jan 2021 19:13:08 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55DF311C069;
        Wed, 13 Jan 2021 19:13:13 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47EFD11C04A;
        Wed, 13 Jan 2021 19:13:10 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.57.196])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Jan 2021 19:13:10 +0000 (GMT)
Message-ID: <97328fc71687a0e1c327f6821548be9ba35bb193.camel@linux.ibm.com>
Subject: Re: [PATCH v10 8/8] selinux: include a consumer of the new IMA
 critical data hook
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Paul Moore <paul@paul-moore.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, tyhicks@linux.microsoft.com,
        sashal@kernel.org, James Morris <jmorris@namei.org>,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Wed, 13 Jan 2021 14:13:09 -0500
In-Reply-To: <CAHC9VhSJk0wG=WzO3bwsueiy19mMi9m6MamTrQfH8C=gXUtvGw@mail.gmail.com>
References: <20210108040708.8389-1-tusharsu@linux.microsoft.com>
         <20210108040708.8389-9-tusharsu@linux.microsoft.com>
         <CAHC9VhSJk0wG=WzO3bwsueiy19mMi9m6MamTrQfH8C=gXUtvGw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-13_09:2021-01-13,2021-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 clxscore=1015 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101130113
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-01-12 at 11:27 -0500, Paul Moore wrote:
> On Thu, Jan 7, 2021 at 11:07 PM Tushar Sugandhi
> <tusharsu@linux.microsoft.com> wrote:
> > From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> >
> > SELinux stores the active policy in memory, so the changes to this data
> > at runtime would have an impact on the security guarantees provided
> > by SELinux.  Measuring in-memory SELinux policy through IMA subsystem
> > provides a secure way for the attestation service to remotely validate
> > the policy contents at runtime.
> >
> > Measure the hash of the loaded policy by calling the IMA hook
> > ima_measure_critical_data().  Since the size of the loaded policy
> > can be large (several MB), measure the hash of the policy instead of
> > the entire policy to avoid bloating the IMA log entry.
> >
> > To enable SELinux data measurement, the following steps are required:
> >
> > 1, Add "ima_policy=critical_data" to the kernel command line arguments
> >    to enable measuring SELinux data at boot time.
> > For example,
> >   BOOT_IMAGE=/boot/vmlinuz-5.10.0-rc1+ root=UUID=fd643309-a5d2-4ed3-b10d-3c579a5fab2f ro nomodeset security=selinux ima_policy=critical_data
> >
> > 2, Add the following rule to /etc/ima/ima-policy
> >    measure func=CRITICAL_DATA label=selinux
> >
> > Sample measurement of the hash of SELinux policy:
> >
> > To verify the measured data with the current SELinux policy run
> > the following commands and verify the output hash values match.
> >
> >   sha256sum /sys/fs/selinux/policy | cut -d' ' -f 1
> >
> >   grep "selinux-policy-hash" /sys/kernel/security/integrity/ima/ascii_runtime_measurements | tail -1 | cut -d' ' -f 6
> >
> > Note that the actual verification of SELinux policy would require loading
> > the expected policy into an identical kernel on a pristine/known-safe
> > system and run the sha256sum /sys/kernel/selinux/policy there to get
> > the expected hash.
> >
> > Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> > Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > ---
> >  Documentation/ABI/testing/ima_policy |  3 +-
> >  security/selinux/Makefile            |  2 +
> >  security/selinux/ima.c               | 64 ++++++++++++++++++++++++++++
> >  security/selinux/include/ima.h       | 24 +++++++++++
> >  security/selinux/include/security.h  |  3 +-
> >  security/selinux/ss/services.c       | 64 ++++++++++++++++++++++++----
> >  6 files changed, 149 insertions(+), 11 deletions(-)
> >  create mode 100644 security/selinux/ima.c
> >  create mode 100644 security/selinux/include/ima.h
> 
> I remain concerned about the possibility of bypassing a measurement by
> tampering with the time, but I appear to be the only one who is
> worried about this so I'm not going to block this patch on those
> grounds.
> 
> Acked-by: Paul Moore <paul@paul-moore.com>

Thanks, Paul.

Including any unique string would cause the buffer hash to change,
forcing a new measurement.  Perhaps they were concerned with
overflowing a counter.

Mimi

> > +/*
> > + * selinux_ima_measure_state - Measure hash of the SELinux policy
> > + *
> > + * @state: selinux state struct
> > + *
> > + * NOTE: This function must be called with policy_mutex held.
> > + */
> > +void selinux_ima_measure_state(struct selinux_state *state)
> > +{
> > +       struct timespec64 cur_time;
> > +       void *policy = NULL;
> > +       char *policy_event_name = NULL;
> > +       size_t policy_len;
> > +       int rc = 0;
> > +
> > +       /*
> > +        * Measure SELinux policy only after initialization is completed.
> > +        */
> > +       if (!selinux_initialized(state))
> > +               return;
> > +
> > +       /*
> > +        * Pass a unique "event_name" to the IMA hook so that IMA subsystem
> > +        * will always measure the given data.
> > +        */
> > +       ktime_get_real_ts64(&cur_time);
> > +       policy_event_name = kasprintf(GFP_KERNEL, "%s-%lld:%09ld",
> > +                                     "selinux-policy-hash",
> > +                                     cur_time.tv_sec, cur_time.tv_nsec);
> > +       if (!policy_event_name) {
> > +               pr_err("SELinux: %s: event name for policy not allocated.\n",
> > +                      __func__);
> > +               goto out;
> > +       }
> > +

