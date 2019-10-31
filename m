Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A052FEB40F
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2019 16:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfJaPho (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 31 Oct 2019 11:37:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30300 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726680AbfJaPho (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 Oct 2019 11:37:44 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9VFahpN051955
        for <linux-integrity@vger.kernel.org>; Thu, 31 Oct 2019 11:37:42 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w027f0j9x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 31 Oct 2019 11:37:42 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 31 Oct 2019 15:37:40 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Oct 2019 15:37:36 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9VFbZ0f31653994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 15:37:35 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6904452069;
        Thu, 31 Oct 2019 15:37:35 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.194.174])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 40B7B52067;
        Thu, 31 Oct 2019 15:37:34 +0000 (GMT)
Subject: Re: [PATCH v3 1/9] KEYS: Defined an IMA hook to measure keys on key
 create or update
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Sasha Levin <sashal@kernel.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     dhowells@redhat.com, matthewgarrett@google.com,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        prsriva@linux.microsoft.com
Date:   Thu, 31 Oct 2019 11:37:33 -0400
In-Reply-To: <20191031152730.GQ1554@sasha-vm>
References: <20191031011910.2574-1-nramas@linux.microsoft.com>
         <20191031011910.2574-2-nramas@linux.microsoft.com>
         <1572523831.5028.43.camel@linux.ibm.com>
         <b83bd7ef-ce7f-e750-e30b-30d5a6469a28@linux.microsoft.com>
         <20191031152730.GQ1554@sasha-vm>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19103115-0012-0000-0000-0000035F8748
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19103115-0013-0000-0000-0000219AD2A2
Message-Id: <1572536253.5028.50.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-31_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910310157
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-10-31 at 11:27 -0400, Sasha Levin wrote:
> On Thu, Oct 31, 2019 at 08:08:48AM -0700, Lakshmi Ramasubramanian wrote:
> >On 10/31/19 5:10 AM, Mimi Zohar wrote:
> >
> >>On Wed, 2019-10-30 at 18:19 -0700, Lakshmi Ramasubramanian wrote:
> >>>Asymmetric keys used for verifying file signatures or certificates
> >>>are currently not included in the IMA measurement list.
> >>>
> >>>This patch defines a new IMA hook namely ima_post_key_create_or_update()
> >>>to measure asymmetric keys.
> >>
> >>It's not enough for the kernel to be able to compile the kernel after
> >>applying all the patches in a patch set.  After applying each patch,
> >>the kernel should build properly, otherwise it is not bi-sect safe.
> >>  Refer to "3) Separate your changes" of
> >>"Documentation/process/submitting-patches.rst.
> >
> >I started with kernel version 5.3 for this patch set.
> >I applied Nayna's process_buffer_measurement() patch and then built my 
> >changes on top of that.
> >This patch has no other dependency as far as I know.
> >
> >Are you seeing a build break after applying this patch alone?
> >
> >(PATCH v3 1/9) KEYS: Defined an IMA hook to measure keys on key create 
> >or update
> 
> I couldn't even apply this patch: Nayna's series (v10) doesn't apply on
> top of 5.3 to begin with, and while it does apply on mainline, this
> first patch wouldn't apply on top.

Lakshmi, development is always on top of mainline.  In this case,
 please use 5.4.0-rc3 and apply Nayna's v10 patch set.

Mimi

