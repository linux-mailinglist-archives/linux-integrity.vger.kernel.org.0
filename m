Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81940553421
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Jun 2022 16:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbiFUOEJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Jun 2022 10:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiFUOEJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Jun 2022 10:04:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B53B12AAF;
        Tue, 21 Jun 2022 07:04:07 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LDtq0C030901;
        Tue, 21 Jun 2022 14:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=95EPxFwW62db/02iZB6Sc7wbkfLf24RnMNVN5Y5ove8=;
 b=LswtMCsjE0V2p9/crZEJNTLYWvydoNQ88oZK+erOwphDi3GD/JiaNnr6wvU7pK3S2FkT
 /cI9E8kvADQCCS0t+po+gjrq6QFNRa4SWrQjeu4lhfiu8tkcRr3UavZTJXnrc3lWWL/d
 FLF0Ka5tIpjyCtd+mLGRvwDqQDXC7dw3cdR8pyJ9hOray7UlSnXfBMzw2vV3Xw0Vgcu0
 C53geWVoI2hOVyRgiAmix8APzRn94bVNWXjtll6t4iQCTVJf5TrJRrQKH3Dg52qmxzzv
 JPjOzcrk+xB/q2uTT3DZmk7XrpQF7+bIl1W7gJEHVJCY1BKp0FTcAZYqcYJZBp+wQM+U YA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gufa0g8gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jun 2022 14:03:46 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25LE1hc0029144;
        Tue, 21 Jun 2022 14:03:45 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gufa0g8fq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jun 2022 14:03:45 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25LDosP4008344;
        Tue, 21 Jun 2022 14:03:44 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3gs5yhm53t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jun 2022 14:03:43 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25LE3fTM19792142
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 14:03:41 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95A49A4060;
        Tue, 21 Jun 2022 14:03:41 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A5FEA405C;
        Tue, 21 Jun 2022 14:03:40 +0000 (GMT)
Received: from sig-9-65-64-13.ibm.com (unknown [9.65.64.13])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Jun 2022 14:03:40 +0000 (GMT)
Message-ID: <5d0c291bb4a674a6733a18f9eb67cf40193732f4.camel@linux.ibm.com>
Subject: Re: [PATCH -next] evm: Use IS_ENABLED to initialize .enabled
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     xiujianfeng <xiujianfeng@huawei.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 21 Jun 2022 10:03:39 -0400
In-Reply-To: <812c4ee9-56f7-900a-df48-f3ca3e15542f@huawei.com>
References: <20220606101042.89638-1-xiujianfeng@huawei.com>
         <64511312-df94-c40b-689c-5fc3823e91f5@pengutronix.de>
         <812c4ee9-56f7-900a-df48-f3ca3e15542f@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sc-cLhOOXlux62wlkyoXKORyFgam6zbC
X-Proofpoint-ORIG-GUID: Yf3cyXtm2a6RXtX5F4LrU-CGLPLqhedo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-21_06,2022-06-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-06-21 at 18:58 +0800, xiujianfeng wrote:
> Hi, Ahmad
> 
> 在 2022/6/7 14:06, Ahmad Fatoum 写道:
> > On 06.06.22 12:10, Xiu Jianfeng wrote:
> >> Use IS_ENABLED(CONFIG_XXX) instead of #ifdef/#endif statements to
> >> initialize .enabled, minor simplicity improvement.

The difference between using ifdef's and IS_ENABLED is when the
decision is made - build time, run time.   Please update the patch
description providing an explanation for needing to make the decision
at run time.

thanks,

Mimi

