Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1AE8344E09
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Mar 2021 19:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhCVSDG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Mar 2021 14:03:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11170 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231278AbhCVSCq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Mar 2021 14:02:46 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12MHXUVC189913;
        Mon, 22 Mar 2021 14:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=5BgpEm/KgpyLlQ/FXu7QQDWMHNtP+UQkOBNYj4Q1nkI=;
 b=P2Nfq0QnqP/Xa0G5kouusJ8r7yFLFiq5IxBVkbSWTZkUYRE2rF1X019U/JSvlterYdJD
 ZXd9OTB/f+y4XTOj7KZr9j/E58OFE2vQNoxnipzQzASvg7KMzE1gAmf05qRZYvltqQfY
 9izA2dTuLjr1Js4ZUc3WS8qcvsiIN0PNIkEHX+DWgQjA8uza59djTAT5Htjvd0VzoItV
 d8VBPKpxRDxIQVGajgC0ns8d+czZc7cBGLtVg+Jy3bMmTkotrhllkUM5C0zI81pcFC8d
 9BkAcnE8bZGwfCBTrr8PJlV5m4THl7c4oGTPsPF88Ue7VwwvFLVQaTEH1Wp5sdsU8MSJ fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37dx9xsevm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 14:02:35 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12MHXbdC190233;
        Mon, 22 Mar 2021 14:02:35 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37dx9xsev0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 14:02:34 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12MHwwXX021270;
        Mon, 22 Mar 2021 18:02:33 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 37d99rakbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 18:02:33 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12MI2Va138994384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 18:02:31 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E51DE4C040;
        Mon, 22 Mar 2021 18:02:30 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C35084C04A;
        Mon, 22 Mar 2021 18:02:28 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.152.56])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 22 Mar 2021 18:02:28 +0000 (GMT)
Message-ID: <92d2e1860d209fe22f8ae5696fc9496e15dd2b31.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] ima: don't access a file's integrity status before
 an IMA policy is loaded
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Date:   Mon, 22 Mar 2021 14:02:27 -0400
In-Reply-To: <YFjLG7+mhDgsQOYu@gmail.com>
References: <20210322154207.6802-1-zohar@linux.ibm.com>
         <YFjLG7+mhDgsQOYu@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-22_09:2021-03-22,2021-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220127
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-03-22 at 09:51 -0700, Eric Biggers wrote:
> On Mon, Mar 22, 2021 at 11:42:06AM -0400, Mimi Zohar wrote:
> > Only after an IMA policy is loaded, check, save, or update the cached
> > file's integrity status.
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> 
> This commit message doesn't describe what the actual effect of this change is.
> Is it fixing something?

No, it's just short circuiting out even earlier, but isn't needed.

Mimi



