Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3145EDE7E
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Sep 2022 16:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbiI1OMH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Sep 2022 10:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiI1OMG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Sep 2022 10:12:06 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9499E2C8;
        Wed, 28 Sep 2022 07:12:05 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SCYGnl006798;
        Wed, 28 Sep 2022 14:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=2qfwID3iDQdHFwDSNCdNKGmKTyUW+HPVTmc7dFG8/NU=;
 b=KwLgNRfNok8OahPwxgAxiGNaoHtT0b0XBE+3pGKmo/KWHs0ez+/LPD+iLiu5GkJpHwk8
 7NVjlw0OXx9Gg2yxjythgtXjyr2WbMqmubJsR7HlHiNnpfNfeW+DQImFB0vhusXwHtLp
 lAI6NDUMpDpYfYgvrOZ8CxzPzTntwWEcJlgof29gtCTyweii2DyxQCUjLkmQ0hM2jN5F
 jelt4aYRASuGw0x40OiG1AFLgH4MY+JDD2yMmk72fumeFC6Q0HsgJWv1pMHntCsNfnVy
 5cJ981R2k1NwWJhnELS1TiYK2d/wcq7kqHTO6NJxGC09hu0hUPYKoxfDgnBQOCegQYyO mQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jvpcwb5pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 14:11:48 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28SDbN2q018490;
        Wed, 28 Sep 2022 14:11:48 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jvpcwb5pa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 14:11:48 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28SE6oVc019244;
        Wed, 28 Sep 2022 14:11:47 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 3jsshajae5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 14:11:47 +0000
Received: from smtpav02.wdc07v.mail.ibm.com ([9.208.128.114])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28SEBjwd10748614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Sep 2022 14:11:46 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C176058070;
        Wed, 28 Sep 2022 14:11:45 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6AF4358058;
        Wed, 28 Sep 2022 14:11:44 +0000 (GMT)
Received: from sig-9-65-238-59.ibm.com (unknown [9.65.238.59])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 28 Sep 2022 14:11:44 +0000 (GMT)
Message-ID: <5e304b17fe709d2b2f30b991d5ffc4711d27a075.camel@linux.ibm.com>
Subject: Re: [PATCH v5 2/2] ima: Handle -ESTALE returned by
 ima_filter_rule_match()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Guozihua (Scott)" <guozihua@huawei.com>,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Janne Karhunen <janne.karhunen@gmail.com>
Date:   Wed, 28 Sep 2022 10:11:43 -0400
In-Reply-To: <7ac3e330-e77c-95d8-7d3b-29e243b57251@huawei.com>
References: <20220921125804.59490-1-guozihua@huawei.com>
         <20220921125804.59490-3-guozihua@huawei.com>
         <ce948f9e5639345026679b31a818cc12a247ce60.camel@linux.ibm.com>
         <77c9c86b-85a6-aa87-e084-59a70bb47167@huawei.com>
         <f321c638bf5572088a8c5e4d7027c3a797bdd568.camel@linux.ibm.com>
         <7ac3e330-e77c-95d8-7d3b-29e243b57251@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 23Dq_TGVV4wtaHlEprzBXYS1W1BgN42o
X-Proofpoint-ORIG-GUID: -l7MlE2jINQHwGnb_yNeA2OjCOWhSqR2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_06,2022-09-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209280085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2022-09-24 at 14:05 +0800, Guozihua (Scott) wrote:

> I might have overlooked something, but if I understands the code 
> correctly, we would be copying the same rule over and over again till 
> the loop ends in that case. ima_lsm_update_rule() would replace the rule 
> node on the rule list without updating the rule in place. Although 
> synchronize_rcu() should prevent a UAF, the rule in ima_match_rules() 
> would not be updated. Meaning SELinux would always return -ESTALE before 
> we copy and retry as we keep passing in the outdated rule entry.

After reviewing this patch set again, the code looks fine.  The commit
message is still a bit off, but I've pushed the patch set out to next-
integrity-testing, waiting for some Reviewed-by/Tested-by tags.

-- 
thanks,

Mimi

