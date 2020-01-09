Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11265135248
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Jan 2020 05:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgAIEwg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jan 2020 23:52:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32310 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726913AbgAIEwg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jan 2020 23:52:36 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0094qXqt009040
        for <linux-integrity@vger.kernel.org>; Wed, 8 Jan 2020 23:52:35 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xdvguhjan-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 08 Jan 2020 23:52:35 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 9 Jan 2020 04:52:30 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 Jan 2020 04:52:26 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0094pcG138011312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Jan 2020 04:51:38 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2F414C046;
        Thu,  9 Jan 2020 04:52:25 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F3C34C044;
        Thu,  9 Jan 2020 04:52:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.236.182])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Jan 2020 04:52:24 +0000 (GMT)
Subject: Re: [PATCH v1] IMA: fix measuring asymmetric keys Kconfig
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        James.Bottomley@HansenPartnership.com, arnd@arndb.de,
        linux-integrity@vger.kernel.org
Cc:     dhowells@redhat.com, sashal@kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org
Date:   Wed, 08 Jan 2020 23:52:23 -0500
In-Reply-To: <20200108160508.5938-1-nramas@linux.microsoft.com>
References: <20200108160508.5938-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20010904-4275-0000-0000-00000395FAC4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010904-4276-0000-0000-000038A9E990
Message-Id: <1578545543.5147.32.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-08_07:2020-01-08,2020-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001090044
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-01-08 at 08:05 -0800, Lakshmi Ramasubramanian wrote:
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is a tristate. If this config
> is set to "=m", ima_asymmetric_keys.c is built as a kernel module.
> 
> Defined an intermediate boolean config namely
> CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS that is
> defined when CONFIG_IMA and CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> are defined.
> 
> Asymmetric key structure is defined only when
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is defined. Since the IMA hook
> measures asymmetric keys, the IMA hook is defined in
> ima_asymmetric_keys.c which is built only if
> CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS is defined.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

For the time being, I've pushed out this patch with the existing patch
description to next-integrity-testing, but the patch description
should be rewritten clearer.  For example,

As a result of the asymmetric public keys subtype being defined as a
tristate, with the existing IMA Makefile, ima_asymmetric_keys.c could
be built as a kernel module.  To prevent this from happening, this
patch defines and uses an intermediate Kconfig boolean option named
IMA_MEASURE_ASYMMETRIC_KEYS.

Please let me know if you're ok with this wording.

thanks,

Mimi

