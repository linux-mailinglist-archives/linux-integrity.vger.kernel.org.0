Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A69D474677
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Dec 2021 16:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbhLNPbe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Dec 2021 10:31:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37094 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233800AbhLNPbe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Dec 2021 10:31:34 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BEElBpN017050;
        Tue, 14 Dec 2021 15:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=GSwyNylE9n2DqEIhkIOpQhDxJpB1Ue9IcyTFoZPTrBA=;
 b=EbG6wF2c11XIMfwqaVA+yiGf+I3zESXehVDGINWfJZEbN50jv8W32c+UuDxZoodTn146
 IDjpYai9xxSgNQzl9nPGz/CejiqUkX23C2RpI6SR+MdT+FubYXovGp5ebTjHtsl/zyGG
 pKcRRrWEWMp0Do2Jix6ZZLSTjqTw7rHCVjGX4WiDRojCJ15COzyxtg8E4+zjTAU78NsU
 xaotCp8NlRabSqE+p3IyJF+DOKmdX4nrNtxzG/5GLnLXxCSsSYocaWmIfk8PH8PH/qJC
 rujKZg0GUlMM4DhBK0KFHAN/GuSLQ1WX8ltCEqC0eOTJPoZh/ftVYXvY0Wwa2TK6ryUv sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cx9r8h2h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Dec 2021 15:31:28 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BEElFv2017498;
        Tue, 14 Dec 2021 15:31:28 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cx9r8h2fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Dec 2021 15:31:28 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BEEiDbk006167;
        Tue, 14 Dec 2021 15:31:25 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3cvk8j0r5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Dec 2021 15:31:25 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BEFVM2Z13435248
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 15:31:22 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCC9A11C050;
        Tue, 14 Dec 2021 15:31:22 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29A4D11C058;
        Tue, 14 Dec 2021 15:31:22 +0000 (GMT)
Received: from sig-9-65-91-220.ibm.com (unknown [9.65.91.220])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 Dec 2021 15:31:22 +0000 (GMT)
Message-ID: <d99fc78005d8a245449dd6ca0158cf9e2a897465.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Fix undefined arch_ima_get_secureboot() and co
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Takashi Iwai <tiwai@suse.de>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joey Lee <jlee@suse.com>
Date:   Tue, 14 Dec 2021 10:31:21 -0500
In-Reply-To: <20211213161145.3447-1-tiwai@suse.de>
References: <20211213161145.3447-1-tiwai@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9BUXuZ_tbKx_GBwnrMNVy16ohG_ofw7N
X-Proofpoint-GUID: yv4D8U1mut7e6ZUTzx8cjriYNfHv9F9z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-14_07,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1011 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112140089
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Takashi,

On Mon, 2021-12-13 at 17:11 +0100, Takashi Iwai wrote:
> Currently arch_ima_get_secureboot() and arch_get_ima_policy() are
> defined only when CONFIG_IMA is set, and this makes the code calling
> those functions without CONFIG_IMA failing.  Although there is no such
> in-tree users, but the out-of-tree users already hit it.
> 
> Move the declaration and the dummy definition of those functions
> outside ifdef-CONFIG_IMA block for fixing the undefined symbols.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Before lockdown was upstreamed, we made sure that IMA and lockdown
could co-exist.  This patch makes the stub functions available even
when IMA is not configured.  Do the remaining downstream patches
require IMA to be disabled or can IMA co-exist?

thanks,

Mimi

