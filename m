Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C694259C1C5
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Aug 2022 16:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiHVOl4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Aug 2022 10:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbiHVOlz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Aug 2022 10:41:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733CC371A0
        for <linux-integrity@vger.kernel.org>; Mon, 22 Aug 2022 07:41:52 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MDvJSo002744;
        Mon, 22 Aug 2022 14:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=tBuPlWYEimIRE9vBf3hYxSbihgOhv8e8K7hzR3uL+mQ=;
 b=hM/hsIDL0iCtKdLnX01FlpoaB/itPrEMTllWQxTJ8KpgcXFyFcJc6T7SaGUIu2hSK+je
 u8OyRYq3I09rwMm+RnFDedbr49BAaRjrAch39kz23Z64jrjiU0dU7v9xmQHZT7zas+a8
 ZcMANWsCoA+yemqbXQKGXZ+HXqG/pJCEEZ5p9U1hPbuBsu2dvFQRJPrDL7YkdR7elT6L
 iPnTb6NK/PmuXDmrlLvCaMp5ad/aq0dfd+SmNtZWgaEaqxXMBgaTcs410CcADJXGjCNF
 C78OyPecif05CIyByEagAzzG+psL2aqLVwNtl2fwHYIR3urxSz+oQuTt8BBIPDze5d4W 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3j4b4x1dmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 14:41:45 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27ME0GfE017166;
        Mon, 22 Aug 2022 14:41:45 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3j4b4x1dm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 14:41:44 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27MEYwmm019588;
        Mon, 22 Aug 2022 14:41:43 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3j2q88tjke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 14:41:42 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27MEfeYT28312046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 14:41:40 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9332111C04C;
        Mon, 22 Aug 2022 14:41:40 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 508A111C050;
        Mon, 22 Aug 2022 14:41:39 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.163.20.129])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 22 Aug 2022 14:41:39 +0000 (GMT)
Message-ID: <c61de998f8ed1e1192297f9a2ce568a86cee3296.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Handle -ESTALE returned by ima_filter_rule_match()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Guozihua (Scott)" <guozihua@huawei.com>,
        linux-integrity@vger.kernel.org, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com
Date:   Mon, 22 Aug 2022 10:41:38 -0400
In-Reply-To: <998ca87c-8eef-8d50-e1ee-da53ef8f0046@huawei.com>
References: <20220818020551.18922-1-guozihua@huawei.com>
         <b383f302284dfa31408e2796a9cae60eefd45004.camel@linux.ibm.com>
         <998ca87c-8eef-8d50-e1ee-da53ef8f0046@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ox-za2N_ge7kspQrbrf545_8Nrd9M5sj
X-Proofpoint-GUID: QsyRPLWa8DTjpEPoQW8rHI_UteIOzR_C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_08,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-08-19 at 09:50 +0800, Guozihua (Scott) wrote:
> On 2022/8/18 21:43, Mimi Zohar wrote:
> > Hi Scott,
> > 
> > On Thu, 2022-08-18 at 10:05 +0800, GUO Zihua wrote:
> >> IMA relies on lsm policy update notifier to be notified when it should
> >> update it's lsm rules.
> > 
> > ^IMA relies on the blocking LSM policy notifier callback to update the
> > LSM based IMA policy rules.
> 
> I'll fix this in the next version.

Thanks.

> > 
> >> When SELinux update it's policies, ima would be notified and starts
> >> updating all its lsm rules one-by-one. During this time, -ESTALE would
> >> be returned by ima_filter_rule_match() if it is called with a lsm rule
> >> that has not yet been updated. In ima_match_rules(), -ESTALE is not
> >> handled, and the lsm rule is considered a match, causing extra files
> >> be measured by IMA.
> >>
> >> Fix it by retrying for at most three times if -ESTALE is returned by
> >> ima_filter_rule_match().
> > 
> > With the lazy LSM policy update, retrying only once was needed.  With
> > the blocking LSM notifier callback, why is three times needed?  Is this
> > really a function of how long it takes IMA to walk and update ALL the
> > LSM based IMA policy rules?  Would having SELinux wait for the -ESTALE
> > to change do anything?
> 
> With lazy policy update, policy update is triggered and would be 
> finished before retrying. However, with a notifier callback, the update 
> runs in a different process which might introduce extra latency. 
> Technically if one rule has been updated, any following rules would have 
> been updated at the time they are read as well, thus the retry should 
> happen on the first rule affected by SELinux policy update only. 
> Retrying for three times here would leave some time for the notifier to 
> finish it's job on updating the rules.

The question is whether we're waiting for the SELinux policy to change
from ESTALE or whether it is the number of SELinux based IMA policy
rules or some combination of the two.  Retrying three times seems to be
random.  If SELinux waited for ESTALE to change, then it would only be
dependent on the time it took to update the SELinux based IMA policy
rules.

thanks,

Mimi

> >>
> >> Fixes: b16942455193 ("ima: use the lsm policy update notifier")
> >> Signed-off-by: GUO Zihua <guozihua@huawei.com>

