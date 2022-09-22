Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66165E60BC
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Sep 2022 13:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiIVLQv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Sep 2022 07:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiIVLQu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Sep 2022 07:16:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B52DE0EE;
        Thu, 22 Sep 2022 04:16:47 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MBCkjq019080;
        Thu, 22 Sep 2022 11:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=VfeMk0I8CyGmHAproj3iFDcN1iVRvDX2EbPo3dGUoHU=;
 b=ZsSbQLpGk2nsEzC/Zv6mUrhbGYU6bmq9uwFJORd22PFRX9NCZQaM1lCdzX/L8Jdrjang
 sl8xksCo1VYB6WK8en7rcr8FYTapwROdDzB0zAxnOFwaS15X7CU8HpkSx3XWdhppQMTu
 Ou+PBe2pldqkEe94W1KFwfyASpXUmPI0Mbb6YD1FANcm9E+Ihpy1Csb4DQDcgFiNGFfH
 Ug+t5nkMOXl8KMgLcpsRlIwQPcwEmjywOHZFCstsfC1/labQNw4w3G1IJZXoYCIE1aJI
 V+1HBef3iuxU1fpPPa3YiSHN/EuYTOxR6FQVDI9pt2XIOCOUBgcwbGBxzVxC6uO1awc+ uA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jrpmp83eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 11:16:34 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28MBGXpH008491;
        Thu, 22 Sep 2022 11:16:33 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jrpmp83bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 11:16:33 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28MB75ft025530;
        Thu, 22 Sep 2022 11:11:30 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 3jn5va8bba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 11:11:30 +0000
Received: from smtpav05.dal12v.mail.ibm.com ([9.208.128.132])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28MBBUMJ1508090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 11:11:30 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B169E58052;
        Thu, 22 Sep 2022 11:11:28 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F5B158065;
        Thu, 22 Sep 2022 11:11:28 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.73.181])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 22 Sep 2022 11:11:28 +0000 (GMT)
Message-ID: <ce948f9e5639345026679b31a818cc12a247ce60.camel@linux.ibm.com>
Subject: Re: [PATCH v5 2/2] ima: Handle -ESTALE returned by
 ima_filter_rule_match()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     GUO Zihua <guozihua@huawei.com>, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Thu, 22 Sep 2022 07:09:57 -0400
In-Reply-To: <20220921125804.59490-3-guozihua@huawei.com>
References: <20220921125804.59490-1-guozihua@huawei.com>
         <20220921125804.59490-3-guozihua@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mwfEG8_b1bKJ5ffsvDXjbwyrebLvu5Oe
X-Proofpoint-GUID: 33ygfeGxtpU_f8UJmvQG2muEPdBe0PX6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_07,2022-09-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209220074
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Scott,

On Wed, 2022-09-21 at 20:58 +0800, GUO Zihua wrote:
>                 }
> -               if (!rc)
> -                       return false;
> +
> +               if (rc == -ESTALE && !rule_reinitialized) {

Ok, this limits allocating ima_lsm_copy_rule() to the first -ESTALE,

> +                       lsm_rule = ima_lsm_copy_rule(rule);
> +                       if (lsm_rule) {
> +                               rule_reinitialized = true;
> +                               goto retry;

but "retry" is also limited to the first -ESTALE.

> +                       }
> +               }
> +               if (!rc) {
> +                       result = false;
> +                       goto out;
> +               }
>         }
> -       return true;
> +       result = true;
> +
> +out:
> +       if (rule_reinitialized) {
> +               for (i = 0; i < MAX_LSM_RULES; i++)
> +                       ima_filter_rule_free(lsm_rule->lsm[i].rule);
> +               kfree(lsm_rule);
> +       }
> +       return result;
>  }

-- 

thanks,

Mimi

