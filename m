Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906714C4F33
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Feb 2022 20:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbiBYT7S (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Feb 2022 14:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiBYT7S (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Feb 2022 14:59:18 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E649C2E65;
        Fri, 25 Feb 2022 11:58:45 -0800 (PST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21PJmq3f027536;
        Fri, 25 Feb 2022 19:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Fnh9r9wKr7jIMlya5SaxcWb+2Shq91enWO70V3Nm2NE=;
 b=EC99Fb0H7umBiPtpMCr0tJsHXkcHGdi1ZsDHkbDkfyO5t8LmlkSja9ooYBKp4NF/gUcs
 ZPFJ6rhpvsxyGm2Vk6AhHwEVwToo1Z7Hbj9uAEn4YVWTPDBZlbKNen2hYIdcvgeUKwnd
 bW8dgWV1QLXF5N+a4KgrTOf2sDPYZqUbWCYcXgKEQnawHp4u5+p4DiMeFZQ3zdauhnc9
 AJ7NDRugp8ImPOPs0hZ3/rpneWCPpBoDlf8n+E56qLi/B8o29FFDUnYF7RUJkPw/LsqD
 3hNTFoESYEFPYxUge2cQpMOF0xyabE5j4BkJmA6rXVuIr7GFbALDBEFTuDj4Vv110ldX xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ef5km852y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 19:58:29 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21PJsQJO025577;
        Fri, 25 Feb 2022 19:58:29 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ef5km851v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 19:58:28 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21PJl28N021266;
        Fri, 25 Feb 2022 19:58:26 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3ear69trk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 19:58:26 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21PJwOWG25493906
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 19:58:24 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23EE211C05C;
        Fri, 25 Feb 2022 19:58:24 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF9F011C050;
        Fri, 25 Feb 2022 19:58:22 +0000 (GMT)
Received: from sig-9-65-82-248.ibm.com (unknown [9.65.82.248])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 25 Feb 2022 19:58:22 +0000 (GMT)
Message-ID: <c4842493db13fd6f05eda54c1ef4c94e9d687850.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] integrity: double check iint_cache was initialized
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Petr Vorel <pvorel@suse.cz>
Cc:     dvyukov@google.com, ebiggers@kernel.org, jmorris@namei.org,
        keescook@chromium.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com
Date:   Fri, 25 Feb 2022 14:58:21 -0500
In-Reply-To: <9405bcfc-78bd-8e7f-41d4-b919221f73e4@schaufler-ca.com>
References: <20210322154207.6802-2-zohar@linux.ibm.com>
         <20220224142025.2587-1-pvorel@suse.cz>
         <418628ea-f524-05a1-8bfc-a688fa2d625d@schaufler-ca.com>
         <YhfDhYQYZTU0clAf@pevik>
         <9405bcfc-78bd-8e7f-41d4-b919221f73e4@schaufler-ca.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QUwHIFcl234phOjcAJAkr-IY8AONcEC_
X-Proofpoint-GUID: HTleStUxReyXIHTLLvv8ZHNGxFIE4g6J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-25_10,2022-02-25_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=909 impostorscore=0 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202250110
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr, Casey,

On Thu, 2022-02-24 at 10:51 -0800, Casey Schaufler wrote:
> On 2/24/2022 9:42 AM, Petr Vorel wrote:

> It was always my expectation, which appears to have been poorly
> communicated, that "making integrity an LSM" meant using the LSM
> hook infrastructure. Just adding "integrity" to lsm= doesn't make
> it an LSM to my mind.

Agreed.  The actual commit that introduced the change was 3d6e5f6dcf65
("LSM: Convert security_initcall() into DEFINE_LSM()").

-- 
thanks,

Mimi

