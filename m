Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8884BABC1
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Feb 2022 22:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiBQVem (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Feb 2022 16:34:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiBQVem (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Feb 2022 16:34:42 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C872111109A;
        Thu, 17 Feb 2022 13:34:26 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21HLCpqB029719;
        Thu, 17 Feb 2022 21:33:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=1IknNosHkgrIItd4+fz82yY/ZudLplMKSRIl8wwtLPw=;
 b=pQQCjtZw5ATEiWRyDBMN/rgTp0SQvwwErpt1jC31LpWcXQ5vCFmBf8A+DlTJDKd7UkDc
 OMivn8AKW2kHSegw09cJVZIqllQDHdiQksEcU3kbpn1lrFD+i0z9KMQ3B6woq+V70gyS
 gViVQhsUsRkNhxxdiUy/LuPmp3qm45NdH2bB+ARfzjQ0AEdwxNs93oHRFq2x9apzv+qf
 iFCiPsFaU83KqHQGAdCMc6G7NQne5cF5ro52vbCf3iDTlpLbU788WQyWX7V53kgVgyed
 TyTwRxyAiUZx3boiEU8L9rOkFFGWJ6P0KJwPTSEyCEguEmNGZhMAJkIZbxyMSCj4MsGR gA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e9w6chfva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 21:33:06 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21HLRFsa024521;
        Thu, 17 Feb 2022 21:33:05 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e9w6chfun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 21:33:05 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21HLDgYZ010027;
        Thu, 17 Feb 2022 21:33:03 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 3e645kbguk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 21:33:03 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21HLX0cF37749028
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 21:33:00 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E83ADA405F;
        Thu, 17 Feb 2022 21:32:59 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8213A4054;
        Thu, 17 Feb 2022 21:32:57 +0000 (GMT)
Received: from sig-9-65-72-122.ibm.com (unknown [9.65.72.122])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Feb 2022 21:32:57 +0000 (GMT)
Message-ID: <d2528ee025956683574775ed9f1bb37665cdfb47.camel@linux.ibm.com>
Subject: Re: [PATCH v10 13/27] ima: Only accept AUDIT rules for
 non-init_ima_ns namespaces for now
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Christian Brauner <brauner@kernel.org>
Date:   Thu, 17 Feb 2022 16:32:52 -0500
In-Reply-To: <20220201203735.164593-14-stefanb@linux.ibm.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
         <20220201203735.164593-14-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zWXwygVsiLw7IdaxqGaPgAy1c5bNdkYl
X-Proofpoint-ORIG-GUID: UGRkoEBLXim_aJhJGwR-23yVWmY0xS0B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-17_08,2022-02-17_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202170102
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-02-01 at 15:37 -0500, Stefan Berger wrote:

> Only accept AUDIT rules for non-init_ima_ns namespaces rejecting all rules
> that require support for measuring, appraisal, and hashing.

It's probably obvious, but adding the words "for now" somewhere in the
above line makes it clear this is temporary.

> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

-- 
thanks,

Mimi



