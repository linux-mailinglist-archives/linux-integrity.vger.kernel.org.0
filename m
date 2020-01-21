Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEDF51444DF
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Jan 2020 20:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgAUTOD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Jan 2020 14:14:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1512 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727523AbgAUTOC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Jan 2020 14:14:02 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00LJ7KJR017265
        for <linux-integrity@vger.kernel.org>; Tue, 21 Jan 2020 14:14:01 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xp2jeup5b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 21 Jan 2020 14:14:01 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 21 Jan 2020 19:13:59 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 Jan 2020 19:13:57 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00LJDuIZ56754334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 19:13:56 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B21C811C05B;
        Tue, 21 Jan 2020 19:13:56 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1341F11C04C;
        Tue, 21 Jan 2020 19:13:56 +0000 (GMT)
Received: from dhcp-9-31-103-231.watson.ibm.com (unknown [9.31.103.231])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Jan 2020 19:13:55 +0000 (GMT)
Subject: Re: [PATCH] IMA: Turn IMA_MEASURE_ASYMMETRIC_KEYS off by default
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 21 Jan 2020 14:13:55 -0500
In-Reply-To: <1579628090.3390.28.camel@HansenPartnership.com>
References: <20200121171302.4935-1-nramas@linux.microsoft.com>
         <1579628090.3390.28.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20012119-0012-0000-0000-0000037F727F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012119-0013-0000-0000-000021BBB361
Message-Id: <1579634035.5125.311.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.634
 definitions=2020-01-21_06:2020-01-21,2020-01-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=3
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001210143
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-01-21 at 09:34 -0800, James Bottomley wrote:
> On Tue, 2020-01-21 at 09:13 -0800, Lakshmi Ramasubramanian wrote:
> > Enabling IMA and ASYMMETRIC_PUBLIC_KEY_SUBTYPE configs will
> > automatically enable the IMA hook to measure asymmetric keys. Keys
> > created or updated early in the boot process are queued up whether
> > or not a custom IMA policy is provided. Although the queued keys will
> > be freed if a custom IMA policy is not loaded within 5 minutes, it
> > could still cause significant performance impact on smaller systems.
> 
> What exactly do you expect distributions to do with this?  I can tell
> you that most of them will take the default option, so this gets set to
> N and you may as well not have got the patches upstream because you
> won't be able to use them in any distro with this setting.
> 
> > This patch turns the config IMA_MEASURE_ASYMMETRIC_KEYS off by
> > default.  Since a custom IMA policy that defines key measurement is
> > required to measure keys, systems that require key measurement can
> > enable this config option in addition to providing a custom IMA
> > policy.
> 
> Well, no they can't ... it's rather rare nowadays for people to build
> their own kernels.  The vast majority of Linux consumers take what the
> distros give them.  Think carefully before you decide a config option
> is the solution to this problem.

James, up until now IMA could be configured, but there wouldn't be any
performance penalty for enabling IMA until a policy was loaded.  With
IMA and asymmetric keys enabled, whether or not an IMA policy is
loaded, certificates will be queued.

My concern is:
- changing the expected behavior
- really small devices/sensors being able to queue certificates

This change permits disabling queueing certificates.  Whether the
default should be "disabled" is a separate question.  I'm open to
comments/suggestions.

Mimi

