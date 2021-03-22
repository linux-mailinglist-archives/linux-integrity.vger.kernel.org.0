Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3099344E0D
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Mar 2021 19:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhCVSDh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Mar 2021 14:03:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50070 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230206AbhCVSDM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Mar 2021 14:03:12 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12MHYYKt178034;
        Mon, 22 Mar 2021 14:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=c3+BGgZgKKiwANiQao9FjerOxBTPM22Sqz4L/kuRF6E=;
 b=qXHn4hfWwn/UDBTP50DPRHNY6u9PI5pi3NxrvQyAQfNZsmDx1vp9kEEzn27unLR8l34K
 BYJyPX2d9pI04opdw2HHW+0Sa0ftKwKlclcntptBsarNQCabO12HYrnCRZ/a0axcNxp1
 XbfLW9WJfBJ7I7Tt5Dw954K0Eru3KecEUMl9AKLdfKOxgrd8FpAU7/g691KVoaHNuAeC
 uj8O3xwhIv5eHMzecHvWbZ+xIdpxUuj03/teBYzCTf4XZIHlQL4LJq7sb1AEBXGZGH1T
 SeWgF299WV8+TvA7M+dkEwXu0cPUu2ignFzP8VbKYdpqFihL94axQG9XjLy8N6iGEzVL 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37dxjw17gs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 14:03:07 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12MHYsmU179251;
        Mon, 22 Mar 2021 14:03:06 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37dxjw17fk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 14:03:06 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12MI2i4l024169;
        Mon, 22 Mar 2021 18:03:04 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 37d9by9b8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 18:03:03 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12MI2hBn27132352
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 18:02:44 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9449B42041;
        Mon, 22 Mar 2021 18:03:01 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9D7542047;
        Mon, 22 Mar 2021 18:02:59 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.152.56])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 22 Mar 2021 18:02:59 +0000 (GMT)
Message-ID: <4a60c669e4b3b9fc75470a2a7e7ec5b4768152cd.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] integrity: double check iint_cache was initialized
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Date:   Mon, 22 Mar 2021 14:02:58 -0400
In-Reply-To: <YFjLWywyF8TYZHxP@gmail.com>
References: <20210322154207.6802-1-zohar@linux.ibm.com>
         <20210322154207.6802-2-zohar@linux.ibm.com> <YFjLWywyF8TYZHxP@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-22_09:2021-03-22,2021-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=608 spamscore=0
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103220127
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-03-22 at 09:52 -0700, Eric Biggers wrote:
> On Mon, Mar 22, 2021 at 11:42:07AM -0400, Mimi Zohar wrote:
> > 
> > Reported-by: Dmitry Vyukov <dvyukov@google.com>
> > Fixes: 79f7865d844c ("LSM: Introduce "lsm=" for boottime LSM selection")
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> 
> Missing Cc stable?

Yes, I was waiting for some comments/review/tags, before adding it.

Mimi

