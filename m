Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC1F64DDB9
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Dec 2022 16:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiLOPWm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Dec 2022 10:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiLOPWT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Dec 2022 10:22:19 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE9463B2;
        Thu, 15 Dec 2022 07:20:46 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFEg8iZ016907;
        Thu, 15 Dec 2022 15:20:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=xdF95zfdlqQe0Hxg5x6UNWrnW1o+HxaeSMyj1IkXHF8=;
 b=ByzoE5MkR3T9Ezoq16/klZGWm/reu6YkwI8Ys1gQkHhC3lNtIezyKf3iiKBy6gT3yv8C
 cSUNRsj5dTz8gciiS6s22PGtCODdwPj5LB2PmM4E2fPXfzGM2jJqoLjBiSPl6GRqOFWj
 3cw50hwWmcEaa8H1Q989ICXZyIHuuNc9LJVZ0WUwlTGhw427poot8rCDMx6aJNdSIcHT
 jhFHjoOmwt6yHHlng7GJH9cn5VswrTSyMLIPoBKFw7qJ2VJNA4JCSm08Vo/FPOrA/mht
 mBZgyqtKW+EYYjSSYF4cJDjc5tsdCnJsmSG42x227aPKMezoLllr5vUUH7UqTYsUgvtO CA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mg3x0vhr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 15:20:41 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BFF0otj012486;
        Thu, 15 Dec 2022 15:20:41 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mg3x0vhqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 15:20:41 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFE7emx006734;
        Thu, 15 Dec 2022 15:20:40 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3mf08eupw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 15:20:40 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BFFKdGC54002034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Dec 2022 15:20:39 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA2505804C;
        Thu, 15 Dec 2022 15:20:38 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D19658067;
        Thu, 15 Dec 2022 15:20:38 +0000 (GMT)
Received: from sig-9-65-242-118.ibm.com (unknown [9.65.242.118])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 15 Dec 2022 15:20:38 +0000 (GMT)
Message-ID: <473749e7a302d0fbb790956e8e1423835a46987a.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: add check for khdr->buffer_size
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "iuppiterlucas@gmail.com" <iuppiterlucas@gmail.com>,
        =?UTF-8?B??= <dmitry.kasatkin@gmail.com>,
        =?UTF-8?B??= <paul@paul-moore.com>,
        =?UTF-8?B??= <jmorris@namei.org>,
        =?UTF-8?B??= <serge@hallyn.com>,
        =?UTF-8?B??= <akpm@linux-foundation.org>,
        =?UTF-8?B??= <linux-integrity@vger.kernel.org>,
        =?UTF-8?B??= <linux-security-module@vger.kernel.org>,
        =?UTF-8?B??= <linux-kernel@vger.kernel.org>
Date:   Thu, 15 Dec 2022 10:20:37 -0500
In-Reply-To: <639b3953.170a0220.35d95.65e9@mx.google.com>
References: <639b3953.170a0220.35d95.65e9@mx.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OvkvSI3i0S_NwEOEm5W-aYJkTb3XlxWZ
X-Proofpoint-ORIG-GUID: h6Dj1SUFIdLa_aKdR5nMxiHwY6OCDkj5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_08,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=692 priorityscore=1501 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212150122
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lucas,

On Thu, 2022-12-15 at 23:12 +0800, iuppiterlucas@gmail.com wrote:
> When khdr->buffer_size > size, continuing to use ima_parse_buf
> 
> may cause memory access out of bounds.
> 
> 
> Fixes: 94c3aac567a9 ("ima: on soft reboot, restore the measurement list")
> 
> 
> Signed-off-by: Lucas Iuppiter <iuppiterlucas@gmail.com>

When posting patches to the linux-integrity mailing list, patches
should be posted in plain text, not mime encoded.

thanks,

Mimi

