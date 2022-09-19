Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C475BD67C
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Sep 2022 23:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiISVg2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Sep 2022 17:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiISVgF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Sep 2022 17:36:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA6A4DF2C;
        Mon, 19 Sep 2022 14:35:25 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JLBwGO009499;
        Mon, 19 Sep 2022 21:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=aoM5yw8cUq44/oS5C96ZyluFX+IlAU/nG1ZdoDOda3Y=;
 b=U6Ktx4pDCxis+AgfZTX4BFTDjBpgMDHk/7n2gYvci2v2y9a/9yq1ZBIwtne5jNmoTxzD
 XJ/fZV0w3NR9zCfvMflgd+xQwDue31YrF5LGxlkMYATnn1ZQIUhC5uWDPogJFr9ponQA
 9/2hxEPVNDxHtPN/Mcp/t3azOj53ZHRS5Z6Z+gZ5AmGStQ5t9r1EKkrOONtVMKfz7im3
 PSxE6wOfme6QS5MbQoHAkoiECsakMa0h/ctRRiccashHTYvO5Vw/g+4LS+YfQYpi2Bm2
 rAD3HoZKcqIg4UrHz9COY+x5ZRUvhRlHED/L6aD9M4pulxMBkU6Pjxj+ZE7MtTBfjMVq Jg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jq04kgg9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 21:35:08 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28JLE3HN020657;
        Mon, 19 Sep 2022 21:35:08 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jq04kgg92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 21:35:08 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28JLL1bY000769;
        Mon, 19 Sep 2022 21:35:07 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02dal.us.ibm.com with ESMTP id 3jn5v9ktuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 21:35:07 +0000
Received: from smtpav02.dal12v.mail.ibm.com ([9.208.128.128])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28JLZ5hT34537914
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 21:35:05 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6C845805E;
        Mon, 19 Sep 2022 21:35:05 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 618A258051;
        Mon, 19 Sep 2022 21:35:05 +0000 (GMT)
Received: from sig-9-77-154-155.ibm.com (unknown [9.77.154.155])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 19 Sep 2022 21:35:05 +0000 (GMT)
Message-ID: <8ed58a588b80e6bcad13fa32b4fca22cbda66f38.camel@linux.ibm.com>
Subject: Re: [PATCH v4 2/2] ima: Handle -ESTALE returned by
 ima_filter_rule_match()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     GUO Zihua <guozihua@huawei.com>, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Mon, 19 Sep 2022 17:35:05 -0400
In-Reply-To: <20220909011516.55957-3-guozihua@huawei.com>
References: <20220909011516.55957-1-guozihua@huawei.com>
         <20220909011516.55957-3-guozihua@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wHga3BFZi1MW2BDiZXtahFwZxnibhYa7
X-Proofpoint-GUID: 1l2v19uLC2FPHVuY1g5obiiB4BQsEtbk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190143
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Scott,

> @@ -612,6 +614,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
>  			else
>  				return false;
>  		}
> +
> +retry:
>  		switch (i) {
>  		case LSM_OBJ_USER:
>  		case LSM_OBJ_ROLE:
> @@ -631,10 +635,28 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
>  		default:
>  			break;
>  		}
> -		if (!rc)
> -			return false;
> +
> +		if (rc == -ESTALE) {
> +			rule = ima_lsm_copy_rule(rule);

Re-using rule here

> +			if (rule) {

and here doesn't look right.

> +				rule_reinitialized = true;
> +				goto retry;
> +			}
> +		}
> +		if (!rc) {
> +			result = false;
> +			goto out;
> +		}
>  	}
> -	return true;
> +	result = true;
> +
> +out:
> +	if (rule_reinitialized) {
> +		for (i = 0; i < MAX_LSM_RULES; i++)
> +			ima_filter_rule_free(rule->lsm[i].rule);
> +		kfree(rule);
> +	}

Shouldn't freeing the memory be immediately after the retry? 
Otherwise, only the last instance of processing -ESTALE would be freed.

> +	return result;
>  }
>  
>  /*

-- 
thanks,

Mimi

