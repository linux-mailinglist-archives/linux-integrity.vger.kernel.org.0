Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161DB773C14
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Aug 2023 18:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjHHQAB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Aug 2023 12:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjHHP6e (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Aug 2023 11:58:34 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546E95BB0
        for <linux-integrity@vger.kernel.org>; Tue,  8 Aug 2023 08:44:17 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378Dad5n001321;
        Tue, 8 Aug 2023 13:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date : to :
 cc : from : subject : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=PKbMWUZL5OPfALHykmHZdHRbDf6wUehGBu74cgOft6g=;
 b=ETjmOiSetlcCFiVyY2wIw2HoKWb1mr4M8KTRxlAv2DvDl2FfAJ52FCNp4wIyguuzIVKH
 e/P9DTxj9sv4QIYFPRZOA1n02+bWbgvXSaNcMZNw6/gZcuRhOrDhlBgC60kKfTH3TUbl
 jT3q9X5tyDdwiuUnbqoZeZoy/KxfFO1WOIEI9D2AjypqOO37fvyJkbSBkx+jFO9GtHu4
 5DZJ7m1/1KU0xleTtQYikePrhD93KmkGnX6o1EcExVqt/ghwUo/HP+DfznPYSsgAQVy/
 1yhCa233t1YkHGbcbFpWalUiLL55HL5cMVPOuoGquJFJ+SD7riUDB7vJk1bqCva+Xwpi ug== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sbpr108xe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 13:40:51 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 378CciUN001785;
        Tue, 8 Aug 2023 13:40:51 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sa3f1pdqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 13:40:51 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 378Deo8F35979890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Aug 2023 13:40:50 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90B2358056;
        Tue,  8 Aug 2023 13:40:50 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60AA55803F;
        Tue,  8 Aug 2023 13:40:50 +0000 (GMT)
Received: from [9.61.3.84] (unknown [9.61.3.84])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  8 Aug 2023 13:40:50 +0000 (GMT)
Message-ID: <ebe1d154-962b-4a8b-ad08-b26e99804c1b@linux.vnet.ibm.com>
Date:   Tue, 8 Aug 2023 09:40:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
From:   Nayna <nayna@linux.vnet.ibm.com>
Subject: Build failure on tpmdd master branch
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fmhLQbjd-YLBnpYBbd7NKyQCVV2dtmCC
X-Proofpoint-ORIG-GUID: fmhLQbjd-YLBnpYBbd7NKyQCVV2dtmCC
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_11,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=769 clxscore=1015
 mlxscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080121
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jarkko,

I rebased the "Enable loading local and third party keys on PowerVM 
guest"( 
https://lore.kernel.org/linux-integrity/20230714153435.28155-1-nayna@linux.ibm.com/) 
on top of tpmdd master branch.

The build is failing due to commit cfa7522f280a ("sysctl: set variable 
key_sysctls storage-class-specifier to static"). A patch with the same 
subject line is already in your tree. Refer to commit 0de030b30823 
("sysctl: set variable key_sysctls storage-class-specifier to static").

Thanks & Regards,

      - Nayna

