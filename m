Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D69D6569E1
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Dec 2022 12:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiL0LXb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Dec 2022 06:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiL0LW6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Dec 2022 06:22:58 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3DA5FA3
        for <linux-integrity@vger.kernel.org>; Tue, 27 Dec 2022 03:22:57 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BR8CGDu030502;
        Tue, 27 Dec 2022 11:22:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=7dx77t0wWkXKp5zcLCyiXiZHh+eAvUvFbmtAF6PaS08=;
 b=EFf/jdcwYJy28p2V0S+NHWUJkdZBWu1vl8qVI5MeGv6r9KDdgrbSvnv9CNj8+HNpGHus
 umEg0CUNZGpJnNxQSP5f4c6RIAQtWHeatVJlWuoRMP2pOIf2EDzu1FEB7XpRHPJyUH4l
 c19EfkFPSj5YzvJ3wvyS1skEnPwtbG/Ri+LDI9e2FB0S/serGzOm4APloo4Lv7w6uXYG
 P6/qcmqGAJLYevJH+XqX1vOM13pDV9tm/RCIUp0m+iYBPy1qcqIpUDQ0t1vE8OBhmr+C
 yFPOJ7fyUwBOeUuf2h20cnO/ZKsFXIPpVK3dh6vZWMJ3k46VaG1/U8GYjl1QPxV+K9Fw Bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mqs1cy5n6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 11:22:48 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BRBGlNq032617;
        Tue, 27 Dec 2022 11:22:48 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mqs1cy5mu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 11:22:48 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BRBCTBW018334;
        Tue, 27 Dec 2022 11:22:47 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3mns27grww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 11:22:47 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BRBMkCA53739792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Dec 2022 11:22:46 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11CE25805B;
        Tue, 27 Dec 2022 11:22:46 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D17758055;
        Tue, 27 Dec 2022 11:22:45 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.23.56])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 27 Dec 2022 11:22:45 +0000 (GMT)
Message-ID: <537bd46f8392c031e2792ef50b5e73bf9aa2f875.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Handle error code from security_audit_rule_match
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     GUO Zihua <guozihua@huawei.com>, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org
Date:   Tue, 27 Dec 2022 06:22:44 -0500
In-Reply-To: <20221227014633.4449-1-guozihua@huawei.com>
References: <20221227014633.4449-1-guozihua@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Rsl9RzPNU2rW_jv9YWQ2Sd6Jn-E30qHP
X-Proofpoint-ORIG-GUID: R-oP6Cry1F3r26kO7kB-FjCE4BozowNF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-27_07,2022-12-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212270091
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-12-27 at 09:46 +0800, GUO Zihua wrote:
> commit c7423dbdbc9e ("ima: Handle -ESTALE returned by
> ima_filter_rule_match()") introduced the handling of -ESTALE returned by
> security_audit_rule_match(). However, security_audit_rule_match() might
> return other error codes if some error occurred. We should handle those
> error codes as well.
> 
> Fixes: c7423dbdbc9e ("ima: Handle -ESTALE returned by ima_filter_rule_match()")
> Signed-off-by: GUO Zihua <guozihua@huawei.com>
> ---
>  security/integrity/ima/ima_policy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 6a68ec270822..5561e1b2c376 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -663,7 +663,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
>  			break;
>  		}
>  
> -		if (rc == -ESTALE && !rule_reinitialized) {
> +		if (rc < 0 && !rule_reinitialized) {

Which other error codes are resolved by retrying?

>  			lsm_rule = ima_lsm_copy_rule(rule);
>  			if (lsm_rule) {
>  				rule_reinitialized = true;

-- 
Thanks,

Mimi

