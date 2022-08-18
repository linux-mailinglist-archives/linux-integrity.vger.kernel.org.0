Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD5D598480
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Aug 2022 15:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243702AbiHRNoa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Aug 2022 09:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245227AbiHRNoC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Aug 2022 09:44:02 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC5A31212
        for <linux-integrity@vger.kernel.org>; Thu, 18 Aug 2022 06:43:45 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27IDTvqd001496;
        Thu, 18 Aug 2022 13:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=byrERlSdX8u9edbQ3GnJH4aA5WxEyLAj/Yc3hAx8aYY=;
 b=ARPdGn5YZ0SSNR2dFiWHyWUUht8px0/vK4CE5Grs1zOfiPF2jH9BNMUcdEZGkCHsMsfE
 LaIOq0G4uDx+1P5dFYRf/+XdnajWrzY7G4Caj+7yRvoxBzDMCyPZZ6NaJjN0ehr8Snrk
 ht+VMoW19wZNoXjhKVPCU/STyN7nOeDrTAEjOEXYcAeelvDruzrHpir46UdaY18hDrok
 ZDIf6mUIWkE3fb46ip1C/mpXbdiPG6nI5O3/seD8UTtCu+zS88er/Nx3pD7DHHVhc1Hu
 249SPBeYHUQkfm3IxJNphBoKvuSGyi2AbSDyx7bT2xMTZTZ1iXqDWZXfi7pMNSeWNk0C Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j1pc48g2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 13:43:40 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27IDUo7m006095;
        Thu, 18 Aug 2022 13:43:39 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j1pc48g0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 13:43:39 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27IDaxnL031795;
        Thu, 18 Aug 2022 13:43:37 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 3hx3k94fyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 13:43:37 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27IDhYv727787578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 13:43:35 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E01E0A405C;
        Thu, 18 Aug 2022 13:43:34 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8EA7FA4054;
        Thu, 18 Aug 2022 13:43:33 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.35.185])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Aug 2022 13:43:33 +0000 (GMT)
Message-ID: <b383f302284dfa31408e2796a9cae60eefd45004.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Handle -ESTALE returned by ima_filter_rule_match()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     GUO Zihua <guozihua@huawei.com>, linux-integrity@vger.kernel.org,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com
Date:   Thu, 18 Aug 2022 09:43:32 -0400
In-Reply-To: <20220818020551.18922-1-guozihua@huawei.com>
References: <20220818020551.18922-1-guozihua@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: z95RSKClQZfyRxkiHptqN5ztBSbm7lv5
X-Proofpoint-GUID: DA4gnzns_ERr-XTB_MAcxKZo9DkhhN5p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_12,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180047
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Scott,

On Thu, 2022-08-18 at 10:05 +0800, GUO Zihua wrote:
> IMA relies on lsm policy update notifier to be notified when it should
> update it's lsm rules.

^IMA relies on the blocking LSM policy notifier callback to update the
LSM based IMA policy rules.

> When SELinux update it's policies, ima would be notified and starts
> updating all its lsm rules one-by-one. During this time, -ESTALE would
> be returned by ima_filter_rule_match() if it is called with a lsm rule
> that has not yet been updated. In ima_match_rules(), -ESTALE is not
> handled, and the lsm rule is considered a match, causing extra files
> be measured by IMA.
> 
> Fix it by retrying for at most three times if -ESTALE is returned by
> ima_filter_rule_match().

With the lazy LSM policy update, retrying only once was needed.  With
the blocking LSM notifier callback, why is three times needed?  Is this
really a function of how long it takes IMA to walk and update ALL the
LSM based IMA policy rules?  Would having SELinux wait for the -ESTALE
to change do anything?

> 
> Fixes: b16942455193 ("ima: use the lsm policy update notifier")
> Signed-off-by: GUO Zihua <guozihua@huawei.com>

thanks,

Mimi

