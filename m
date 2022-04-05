Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EF24F422F
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Apr 2022 23:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238115AbiDEPDM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 5 Apr 2022 11:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353788AbiDENo4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Apr 2022 09:44:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274DD7460F;
        Tue,  5 Apr 2022 05:43:48 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 235CHRJQ031859;
        Tue, 5 Apr 2022 12:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=rAI9DPKAHICQe84g8ES6PkP9uqydWYaPLKbh1T19Tr0=;
 b=jm9CKIIDw+ylnY+3dqie/JNknZ7iFvIwf+cj4UfmTH+obobIK3jgH3ez322A/xBOQTpJ
 k6nz3XGWFVCCgd2gSw7OulGgS7GTgquO9163seD3RFfQeedStWjTeghOrrdwi8+iIQMt
 coNSK3eBB3g9eCVn4R0ONQIqp4hSqU1s3gvH63OIRMBdQNEbWAz6iRo9vKHJg/CYZkt5
 Ou/rm3BsXjr/yvjj76sTXpf71NPIPaxrjdTD29PC43e6IsyuEyOxJ96JmL8+etSRg0So
 DSNLyTFbwDKnw1po8UTsl9+NT1ynuzPZAn3v1YpfQ2QbBQg8APnSrfpSt/Ndjmg1pNu1 JA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f87jtt1kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Apr 2022 12:43:31 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 235Cfk2f005049;
        Tue, 5 Apr 2022 12:43:31 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f87jtt1k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Apr 2022 12:43:30 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 235CdCvV024714;
        Tue, 5 Apr 2022 12:43:28 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3f6e48vqu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Apr 2022 12:43:28 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 235ChPdt46268926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Apr 2022 12:43:26 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFB6D4C04E;
        Tue,  5 Apr 2022 12:43:25 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B09F74C046;
        Tue,  5 Apr 2022 12:43:24 +0000 (GMT)
Received: from sig-9-65-85-150.ibm.com (unknown [9.65.85.150])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Apr 2022 12:43:24 +0000 (GMT)
Message-ID: <6a74d717535179188606dea3c68f56d35a86bac8.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: remove redundant initialization of pointer 'file'.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Date:   Tue, 05 Apr 2022 08:43:24 -0400
In-Reply-To: <20220301120732.670168-1-colin.i.king@gmail.com>
References: <20220301120732.670168-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NsdwNJRoZr6aEmaX6tRdtRFfzIvI9b2W
X-Proofpoint-ORIG-GUID: XZKPOxOY116lUQMtlqbIdsA1H3GZh2A1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-05_02,2022-04-05_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 phishscore=0 suspectscore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 mlxlogscore=643 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204050074
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-03-01 at 12:07 +0000, Colin Ian King wrote:
> The pointer 'file' is being initialized with a value that is never read,
> it is being re-assigned the same value later on closer to where it is
> being first used. The initialization is redundant and can be removed.
> 
> Cleans up clang scan build warning:
> security/integrity/ima/ima_main.c:434:15: warning: Value stored to 'file'
> during its initialization is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

thanks,

Mimi

