Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA1C3D7F58
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 22:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhG0Ui6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Jul 2021 16:38:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52328 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231133AbhG0Ui6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Jul 2021 16:38:58 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16RKXT37171855;
        Tue, 27 Jul 2021 16:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=A+WzdmL2Pl3OYBW3zAceMSAkd5dKDS/Z3IsBEYhnoNs=;
 b=hj1MSxChTH8eex9u03T6ELzMx9RZW8+noXAMEYkLbMkhaUXUnfQ0fnSAv93E2Fe8m+PR
 KJSMxg2AG4vhcwM+yRD0GEqbNivhihofH2M2PyNYBc/18s+tQwzuLG8yXna8G/EzqDKG
 0VROzhlPxxxLAXIShMbAA3Eiqo0mGzmWqlknQGDvqs9zgPIDHNHwA0nOl5kGo6xuFznl
 D9Kr37JORo6i8d5GBD4PkLRg2LFgZNBhlNKDCeWwBh98Eh/tnkLEuA8v2f5na2refkjm
 dE70S9naHNUGr3lm2JGvWSNMVwBa5k2JN/ZAoszNL2xYzKEeClqPujdlUMwFMtijP7jG qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a2rjaheft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 16:38:56 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16RKY7MK174886;
        Tue, 27 Jul 2021 16:38:36 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a2rjahdvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 16:38:36 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16RKEZdT031191;
        Tue, 27 Jul 2021 20:38:16 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3a235xrdx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 20:38:16 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16RKZX1630212556
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 20:35:33 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15F00A4065;
        Tue, 27 Jul 2021 20:38:14 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9579A4069;
        Tue, 27 Jul 2021 20:38:12 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.85.52])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Jul 2021 20:38:12 +0000 (GMT)
Message-ID: <ca33ec3c4cc9625467ce842ebdb17b3ed61d2ab3.camel@linux.ibm.com>
Subject: Re: [PATCH v4 3/5] IMA: add support to restrict the hash algorithms
 used for file appraisal
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Date:   Tue, 27 Jul 2021 16:38:12 -0400
In-Reply-To: <20210727163330.790010-4-simon.thoby@viveris.fr>
References: <20210727163330.790010-1-simon.thoby@viveris.fr>
         <20210727163330.790010-4-simon.thoby@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dkiWxoG48fLB4nWnjWP6Fp5G2OaJnM_Y
X-Proofpoint-ORIG-GUID: txqX7oxVDZ96Zx880ETx5vkdWMwzlvD1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-27_13:2021-07-27,2021-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107270119
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

On Tue, 2021-07-27 at 16:33 +0000, THOBY Simon wrote:
> The kernel accepts any hash algorithm as a value for the security.ima
> xattr. Users may wish to restrict the accepted algorithms to only
> support strong cryptographic ones.
> 
> Provide the plumbing to restrict the permitted set of hash algorithms
> used for verifying file hashes and digest algorithms stored in
> security.ima xattr.
> 
> This do not apply only to IMA in hash mode, it also works with digital
> signatures, in which case it checks that the hash (which was then
> signed by the trusted private key) have been generated with one of
> the algortihms whitelisted for this specific rule.
> 
> Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>

I haven't yet tested building the kernel after applying each patch. 
Assuming that it compiles properly: 

Reviewed-by:  Mimi Zohar <zohar@linux.ibm.com>

