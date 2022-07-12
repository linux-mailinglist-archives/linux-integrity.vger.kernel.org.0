Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F5F5718B7
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Jul 2022 13:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbiGLLkf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Jul 2022 07:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiGLLkf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Jul 2022 07:40:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE87AD869;
        Tue, 12 Jul 2022 04:40:34 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CAcNIh010433;
        Tue, 12 Jul 2022 11:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=uxRmJ+Q3UusrkgxXc/qHV1tSW/A5revJxU/n8Y2w+io=;
 b=WUr9odpv5yiJALYlB2iVDmm5NbKKrU2SeLgcRW2ZhdQZ+ul7mBwERvUiQxSPtJHxdEB0
 bnWsm908X3XUM0b742/HRV0H5dtRY7OZlU4lZ776T9lpKSyzyWwWJPL5hvBXZVZuQzmo
 0I7zLdefMbl0xJCzTEOKYgTFi8X2qeMLkY9JRDTAY2gOZCA/+JW1KImB/lL3imUxOR5I
 1R/V9BjF6Iz2jYuYQpnwRHnCwrzF+vUo4MXm5ik7VvZoXqAQtwY84ssesDE/xrTi98DG
 ZRX8lHHmZnAaAqsih5egAh1LW3KL+nVMZpWoRnnEtoux9MY/ABlqsa2u6PCr903mUQhs AQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h96qfaemj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 11:40:26 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26CAlMNh012943;
        Tue, 12 Jul 2022 11:40:25 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h96qfaekf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 11:40:25 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26CBaEmW007672;
        Tue, 12 Jul 2022 11:40:23 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3h8rrn116k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 11:40:23 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26CBeLus23462380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 11:40:21 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 535F8A405F;
        Tue, 12 Jul 2022 11:40:21 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 606F3A405B;
        Tue, 12 Jul 2022 11:40:19 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.147.132])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jul 2022 11:40:19 +0000 (GMT)
Message-ID: <7dd513fba6c248327a9118e8dafe628d13dde495.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ima/evm: Fix potential memory leak in
 ima_init_crypto()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jianglei Nie <niejianglei2021@163.com>, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jul 2022 07:40:18 -0400
In-Reply-To: <20220712011037.2328591-1-niejianglei2021@163.com>
References: <20220712011037.2328591-1-niejianglei2021@163.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cgH4NewqkjZ0UwAHxoC8ycYRGNQfhzme
X-Proofpoint-GUID: 1ZyU6QD20WvAe1586bMQmGtYfhUJH0m5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_08,2022-07-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015
 suspectscore=0 mlxscore=0 mlxlogscore=700 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-07-12 at 09:10 +0800, Jianglei Nie wrote:
> On failure to allocate the SHA1 tfm, IMA fails to initialize and exits
> without freeing the ima_algo_array. Add the missing kfree() for
> ima_algo_array to avoid the potential memory leak.
> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>

Thanks, Jianglei.  This patch is now queued in next-integrity/next-
integrity-testing.

Mimi

