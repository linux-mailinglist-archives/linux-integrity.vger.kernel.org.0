Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942596773A7
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Jan 2023 01:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjAWAyF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 22 Jan 2023 19:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjAWAyF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 22 Jan 2023 19:54:05 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D91E11E85
        for <linux-integrity@vger.kernel.org>; Sun, 22 Jan 2023 16:54:04 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30MMPP8C033761
        for <linux-integrity@vger.kernel.org>; Mon, 23 Jan 2023 00:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=vsdgnLOBeLbFERGRkqMskFpq1SKDBg95DWFY6M5XvL4=;
 b=TUYeEqbwXk06XeC7Cza4jrMNKFdkHGxf9RYfZLklzAptjBcRH7DaDW0S6UZ4rLr5zWdt
 FoX76Xjxgg2sKcrRQ32I1KtV8vil1hvrPb6nocACRz5XE2lWvFW3jNm9tWX3vrOsIi7F
 j9v9rLwM1HkafmGAyOqFuj65Bs/wkvTr7CtaKJrMCO9xV83Pe8oBj+vk9VS/wVCTs10A
 9ObuKzUQYo05mv64/PMZ7wsh9nNlkxAMsKzCXjejqrS0KJLOqy+7h6xH0jU7WYZCj5Lc
 se+Pd8JhWg0m+8GMnogvkQz52IHUMiWEsEEUdI1vN2N9vPo9+bXCRtsbLvdyTJ3cuq5t Hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n8t47sr63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 23 Jan 2023 00:54:04 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30N0s3rB012995
        for <linux-integrity@vger.kernel.org>; Mon, 23 Jan 2023 00:54:03 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n8t47sr5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 00:54:03 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30MMZ1Qj003198;
        Mon, 23 Jan 2023 00:54:02 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3n87p6shqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 00:54:02 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30N0s1kh60227884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 00:54:01 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15FB258055;
        Mon, 23 Jan 2023 00:54:01 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E97B5804B;
        Mon, 23 Jan 2023 00:54:00 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.186.87])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 23 Jan 2023 00:54:00 +0000 (GMT)
Message-ID: <af4692dae46ec21dd2ecd29c60a8dea18bf90eef.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: fix error handling logic when file measurement
 failed
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matt Bobrowski <mattbobrowski@google.com>,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org
Date:   Sun, 22 Jan 2023 19:54:00 -0500
In-Reply-To: <Y83JvB7+IwxqRgMZ@google.com>
References: <Y7T1eAAVXoZ70MPM@google.com> <Y83JvB7+IwxqRgMZ@google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 02dmEMTDu4FJfESmCnmYomzuN_O0bHBb
X-Proofpoint-GUID: OQp5ocMNss4cBkIT4tY2gp88jLl_5Ezy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-22_18,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301230003
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Matt,

On Sun, 2023-01-22 at 23:41 +0000, Matt Bobrowski wrote:
> Hey Mimi,
> 
> Just a gentle ping on this one. 
> 
> On Wed, Jan 04, 2023 at 03:41:44AM +0000, Matt Bobrowski wrote:
> > Restore the error handling logic so that when file measurement fails,
> > the respective iint entry is not left with the digest data being
> > populated with zeroes.
> > 
> > Fixes: 54f03916fb89 ("ima: permit fsverity's file digests in the IMA measurement list")
> > Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>

As of Friday, they're both queued in the next-integrity branch and in
linux-next shortly.

-- 
thanks,

Mimi

