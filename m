Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF2C77EC13
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Aug 2023 23:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346605AbjHPVmn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Aug 2023 17:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346664AbjHPVm1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Aug 2023 17:42:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD31A2133
        for <linux-integrity@vger.kernel.org>; Wed, 16 Aug 2023 14:42:25 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GLdo2B004795
        for <linux-integrity@vger.kernel.org>; Wed, 16 Aug 2023 21:42:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date : to :
 from : subject : content-type : content-transfer-encoding : mime-version;
 s=pp1; bh=Pq36c4oZSGRp92ITq3gKLwmoScGwFjgRWRXuPw72TOI=;
 b=esJy43Hqip4Rds577cu2RvKk2dI+JQUeG2KNUaBK4oNmij0cF+Vd27O6ci8RH4rK4aKc
 T9pVe6YFAXI5HN3tvxyXMNTgCWCsp33usHBDbwi6U7oJbk77dF/pGF2GeskPm8tzUE0I
 lMEAD8lz0M/AZnxX76j4h4zZhQmx8UMkHoZc0NNnqRNg4ACu3TprXNfoPqcVc73Ulo77
 mL8IjvIR0J0cmoty4/kCrp2ElBytmydTpFvHDHO16wKSkNAxgA4WreI+10OeZo9jaE81
 l8E1OpsLfpVzqrPG4WIkF0YN7xFmDep0KM950tAnoeizuekG5bc+EZKRyspyI/A8Q6Zw nw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sh6ah8616-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 16 Aug 2023 21:42:25 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37GKCqNJ001107
        for <linux-integrity@vger.kernel.org>; Wed, 16 Aug 2023 21:42:24 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3semsyh00m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 16 Aug 2023 21:42:24 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37GLgN0s7602756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-integrity@vger.kernel.org>; Wed, 16 Aug 2023 21:42:23 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D5BA58050
        for <linux-integrity@vger.kernel.org>; Wed, 16 Aug 2023 21:42:23 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E06D958045
        for <linux-integrity@vger.kernel.org>; Wed, 16 Aug 2023 21:42:22 +0000 (GMT)
Received: from [9.67.73.236] (unknown [9.67.73.236])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP
        for <linux-integrity@vger.kernel.org>; Wed, 16 Aug 2023 21:42:22 +0000 (GMT)
Message-ID: <a5ed5a0f-5692-426e-d058-983cf4d9cccb@linux.ibm.com>
Date:   Wed, 16 Aug 2023 17:42:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To:     Linux Integrity <linux-integrity@vger.kernel.org>
From:   Ken Goldman <kgold@linux.ibm.com>
Subject: Linux IMA documentation
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ElrkjYCmewo9aFrZZ59nD1PWq6_uFs98
X-Proofpoint-GUID: ElrkjYCmewo9aFrZZ59nD1PWq6_uFs98
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_18,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxlogscore=426 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160192
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Is this the right place to announce this?  If not, let me know.

https://ima-doc.readthedocs.io/en/latest/index.html

This is a first pass at IMA documentation.  It's targeted at users, not 
kernel developers.

Some areas are clearly incomplete, but I don't think there is anything 
incorrect.

Suggestions, contributions, corrections are all welcome.

The source is at https://github.com/IBM/ima-doc
