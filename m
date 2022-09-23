Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F275E7945
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Sep 2022 13:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiIWLTv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Sep 2022 07:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiIWLTt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Sep 2022 07:19:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32AB23BF5;
        Fri, 23 Sep 2022 04:19:47 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NA0lIN008001;
        Fri, 23 Sep 2022 11:19:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=eVLNts8du4/dAkRp2IkzA6R7Xd1NbFI7u6ng0l298JY=;
 b=XrgMgVsB2oFn2cwjXlvJc/Wq3twkcyVqTN+CL9h8eAhPo9WyQuvQlaIxTrFLGqBs1JHh
 dzmQT6e2Qj4nb0YGXv6Dh+RVyTrKDMtqdq4aoJE4aEhtcy9kQlNpG/ZSNQXQ6Wh1/lae
 caxsWBY5HjesbVfeXDvQh9E8E49cgKoxQxEpjceeKoUcC5L3y0/dcWCWzy/G1qymptPy
 63OJv4gBSKko1ONhcLVTF9USTD8TtRCl7Qy+h53mYkYX1/x9PQhrjlpIjB7DmeBdIAhO
 4IT5IIciuOqYPEl2S/9bXTMC0Lzoh0AzyGOUwE9bSbqVPM3gx/VipMeDsXIQqB4IbvRn 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3js7bdqqkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 11:19:30 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28NAZpKK025246;
        Fri, 23 Sep 2022 11:19:29 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3js7bdqqkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 11:19:29 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28NB7vW7008033;
        Fri, 23 Sep 2022 11:19:28 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02wdc.us.ibm.com with ESMTP id 3jn5v9y764-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 11:19:28 +0000
Received: from smtpav06.wdc07v.mail.ibm.com ([9.208.128.115])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28NBJR2o61407676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Sep 2022 11:19:28 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B463058055;
        Fri, 23 Sep 2022 11:19:27 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEC675804E;
        Fri, 23 Sep 2022 11:19:26 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.5.8])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 23 Sep 2022 11:19:26 +0000 (GMT)
Message-ID: <f321c638bf5572088a8c5e4d7027c3a797bdd568.camel@linux.ibm.com>
Subject: Re: [PATCH v5 2/2] ima: Handle -ESTALE returned by
 ima_filter_rule_match()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Guozihua (Scott)" <guozihua@huawei.com>,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Fri, 23 Sep 2022 07:19:26 -0400
In-Reply-To: <77c9c86b-85a6-aa87-e084-59a70bb47167@huawei.com>
References: <20220921125804.59490-1-guozihua@huawei.com>
         <20220921125804.59490-3-guozihua@huawei.com>
         <ce948f9e5639345026679b31a818cc12a247ce60.camel@linux.ibm.com>
         <77c9c86b-85a6-aa87-e084-59a70bb47167@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kp1VsAdDHC_zCWXYY3Gg28rQXQq5hYnz
X-Proofpoint-ORIG-GUID: IM5NrmwD8jcVmKOq1Gj04LtNdKIDMcdq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_03,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 mlxscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209230072
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-09-23 at 12:01 +0800, Guozihua (Scott) wrote:
> On 2022/9/22 19:09, Mimi Zohar wrote:
> > Hi Scott,
> > 
> > On Wed, 2022-09-21 at 20:58 +0800, GUO Zihua wrote:
> >>                  }
> >> -               if (!rc)
> >> -                       return false;
> >> +
> >> +               if (rc == -ESTALE && !rule_reinitialized) {
> > 
> > Ok, this limits allocating ima_lsm_copy_rule() to the first -ESTALE,
> > 
> >> +                       lsm_rule = ima_lsm_copy_rule(rule);
> >> +                       if (lsm_rule) {
> >> +                               rule_reinitialized = true;
> >> +                               goto retry;
> > 
> > but "retry" is also limited to the first -ESTALE.
> 
> Technically we would only need one retry. This loop is looping on all 
> the lsm members of one rule, and ima_lsm_copy_rule would update all the 
> lsm members of this rule. The "lsm member" here refers to LSM defined 
> properties like obj_user, obj_role etc. These members are of AND 
> relation, meaning all lsm members together would form one LSM rule.
> 
> As of the scenario you mentioned, I think it should be really rare. 
> Spending to much time and code on this might not worth it.
> > 
> >> +                       }
> >> +               }

Either there can be multiple LSM fields and the memory is allocated
once and freed once at the end, as you suggested, or the memory should
be freed here and rule_reinitialized reset, minimizing the code change.

> >> +               if (!rc) {
> >> +                       result = false;
> >> +                       goto out;
> >> +               }
> >>          }
> >> -       return true;
> >> +       result = true;
> >> +
> >> +out:
> >> +       if (rule_reinitialized) {
> >> +               for (i = 0; i < MAX_LSM_RULES; i++)
> >> +                       ima_filter_rule_free(lsm_rule->lsm[i].rule);
> >> +               kfree(lsm_rule);
> >> +       }
> >> +       return result;
> >>   }

-- 
thanks,

Mimi

