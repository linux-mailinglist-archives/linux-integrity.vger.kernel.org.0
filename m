Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7063E54682E
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jun 2022 16:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243193AbiFJOUi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jun 2022 10:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbiFJOUh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jun 2022 10:20:37 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA86AF33A4;
        Fri, 10 Jun 2022 07:20:36 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25ADXxin023507;
        Fri, 10 Jun 2022 14:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=y7F6aAGJJqS6pYIxeYiMNfj4D9EhTZlB+uVA973QynI=;
 b=Y1aMqn3W81UHqjWP1aVUhXZS2Hzo8br4vj+eaASDmiKvWg6sEpqWuICN/l9bjAoADjEu
 qS/S1V9GPniezkaXj3WJa0Y06yyr8dBzS/EQ5da0Av8A9uLkzrirRS5Yucl2NsqI4XhU
 zrBajj/lb6IVANMwgXUdww8gWiwjz+5vQu7Hsl5OrfHJfu0XbCH2s0Ej+G6BnPxOLtk0
 cOrFgCCN61vzECiFV1dnht370hN/F8IWSwHhM1vadkQNZbTTpDkcz75lFsh2tHGr63PW
 CeBHhZjJytOpR4eX9hsV8o81jxlhVf2o5YnOUcjUqsUdFYs9G04/mN3PXKz0X8PMPo2g 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gm6y190pg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 14:20:23 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25ADYL8W024660;
        Fri, 10 Jun 2022 14:20:22 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gm6y190nr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 14:20:22 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25AE68dA011547;
        Fri, 10 Jun 2022 14:20:20 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3gfxnj0cw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 14:20:20 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25AEJvoX23724504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jun 2022 14:19:57 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6EA5411C052;
        Fri, 10 Jun 2022 14:20:18 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A15511C054;
        Fri, 10 Jun 2022 14:20:17 +0000 (GMT)
Received: from sig-9-65-64-7.ibm.com (unknown [9.65.64.7])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 10 Jun 2022 14:20:17 +0000 (GMT)
Message-ID: <5842536c5c2bde1e3c2840f7e877becc3282b47c.camel@linux.ibm.com>
Subject: Re: [PATCH -next] Revert "evm: Fix memleak in init_desc"
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com,
        "Guozihua (Scott)" <guozihua@huawei.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 10 Jun 2022 10:20:15 -0400
In-Reply-To: <20220527111726.195825-1-xiujianfeng@huawei.com>
References: <20220527111726.195825-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KKuVtIHQmFAYn_bXOFDlvDZXJJMnYNXf
X-Proofpoint-GUID: XU765cbsgikOgMxSClaCs7FRkX3ig9KC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_06,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 priorityscore=1501 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206100057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-05-27 at 19:17 +0800, Xiu Jianfeng wrote:
> This reverts commit ccf11dbaa07b328fa469415c362d33459c140a37.
> 
> Commit ccf11dbaa07b ("evm: Fix memleak in init_desc") said there is
> memleak in init_desc. That may be incorrect, as we can see, tmp_tfm is
> saved in one of the two global variables hmac_tfm ohr evm_tfm[hash_algo],
> then if init_desc is called next time, there is no need to alloc tfm
> again, so in the error path of kmalloc desc or crypto_shash_init(desc),
> It is not a problem without freeing tmp_tfm.
> 
> And also that commit did not reset the global variable to NULL after
> freeing tmp_tfm and this makes *tfm a dangling pointer which may cause a
> UAF issue.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Agreed, thanks.  This was first reported by Guozihua (Scott) <
guozihua@huawei.com>.  If neither you nor Scott object, I'll add his
Reported-by tag.

thanks,

Mimi





