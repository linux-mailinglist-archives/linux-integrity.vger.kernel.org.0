Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32CC59E824
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Aug 2022 18:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245708AbiHWQxR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Aug 2022 12:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245723AbiHWQww (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Aug 2022 12:52:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AF712ECC9
        for <linux-integrity@vger.kernel.org>; Tue, 23 Aug 2022 06:21:25 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27NCtWhT009588;
        Tue, 23 Aug 2022 13:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=4T30uoD1G7ycZ2yvc4g7HHYdpjsymVARdZVptRAQQwQ=;
 b=a24XOIDYcRvzHxCpu/m2c0VlvjYYxqdCS1SQIUc4rTupnJMSkyB8rrz60frkMjxxP//V
 reY+r5LHawrOeEVFatLWdVcEPorJeAbXTQfZhXUnG/lNyyNcnE2+7sk8n5UU9jkVt27i
 dTm+imYnTd4FyQUR+uy4LogtPH18+Y6ElrgzzY+TV8Rkx6frqabnPU+FSjBOXaBxsi+4
 COWdAhJv6riWu253oLbwGuG8u7BLQQrh3sgwmuAM2WdvrZvUbf04ItL15psLtIgHL/3J
 hBPNnmWufZjiIjRIjbkI88p9Y2oD2Rz5RfSCpEtB+R9HHaZ14RAuyDkzbfvvbiGYsFWP Fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j4yaqgtss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 13:21:17 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27NCwTbL021509;
        Tue, 23 Aug 2022 13:21:16 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j4yaqgtrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 13:21:16 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27NDL5Zf006300;
        Tue, 23 Aug 2022 13:21:14 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3j2pvj3umx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 13:21:14 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27NDLCe229950268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Aug 2022 13:21:12 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9424AE04D;
        Tue, 23 Aug 2022 13:21:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0ED0AE051;
        Tue, 23 Aug 2022 13:21:10 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.141.37])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Aug 2022 13:21:10 +0000 (GMT)
Message-ID: <dc34912b2bad1c46f249fb6e2aa2c79e26890699.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Handle -ESTALE returned by ima_filter_rule_match()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Guozihua (Scott)" <guozihua@huawei.com>,
        linux-integrity@vger.kernel.org, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com
Date:   Tue, 23 Aug 2022 09:21:09 -0400
In-Reply-To: <d5861fbc-1079-a47f-e746-1072dd1d37d7@huawei.com>
References: <20220818020551.18922-1-guozihua@huawei.com>
         <b383f302284dfa31408e2796a9cae60eefd45004.camel@linux.ibm.com>
         <998ca87c-8eef-8d50-e1ee-da53ef8f0046@huawei.com>
         <c61de998f8ed1e1192297f9a2ce568a86cee3296.camel@linux.ibm.com>
         <d5861fbc-1079-a47f-e746-1072dd1d37d7@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nlYd7UlbwT7wXyFlBo42TTFrMdSPDPW-
X-Proofpoint-ORIG-GUID: 5KW1xnqg8fj6aq5IuKBZJAHX9niXr3Sp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_05,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208230052
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-08-23 at 16:12 +0800, Guozihua (Scott) wrote:
> > The question is whether we're waiting for the SELinux policy to change
> > from ESTALE or whether it is the number of SELinux based IMA policy
> > rules or some combination of the two.  Retrying three times seems to be
> > random.  If SELinux waited for ESTALE to change, then it would only be
> > dependent on the time it took to update the SELinux based IMA policy
> > rules.
> 
> We are waiting for ima_lsm_update_rules() to finish re-initializing all 
> the LSM based rules.

Fine.  Hopefully retrying a maximum of 3 times is sufficient.

-- 
thanks,

Mimi

