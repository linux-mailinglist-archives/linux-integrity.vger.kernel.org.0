Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB36698870
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Feb 2023 00:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjBOXAl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Feb 2023 18:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBOXAl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Feb 2023 18:00:41 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7217D55A9
        for <linux-integrity@vger.kernel.org>; Wed, 15 Feb 2023 15:00:40 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31FLgA5V009090;
        Wed, 15 Feb 2023 23:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=UTIq2Fe7VhsvaBnAUH4EiAu2LtzyIbohzLTM46Jzmt0=;
 b=JbtfZ4W0+f7E8aLjOwZrFxQilMTV+R4W5uP4ZFm3YG65gEO++Wrqm311M71ZOs3IqZsp
 F9BNjLFa+oXmvN9AFp2z1zFGctGFz9UxGn+KTUrK+iZ0uhsQEqC3qtNY6Y/YWjtrqjnv
 VXf/DgTniZIF/spkii2kfj2pgKHKC5uOCKfCqLH5VzeGZ6H79rEnP3huf2mgigldxLd7
 t9B+pBxA65N0NAyrPPITjBdKSCpMLkI+8lzIPYGxRIEHP5X7venD+RKFYF1pdd+EYR3S
 LmH6kGZELGh1u8UejU776AzUA/cPeozT/krG2+RlpeoGI8T1uY7HtuAdF06+C9B6QtEz Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ns7hj9fjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 23:00:29 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31FMHgDT008680;
        Wed, 15 Feb 2023 23:00:28 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ns7hj9fhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 23:00:28 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31FJkbi6020587;
        Wed, 15 Feb 2023 23:00:27 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3np2n77jt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 23:00:27 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31FN0Qs97537230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 23:00:26 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31EA55804B;
        Wed, 15 Feb 2023 23:00:26 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B08458065;
        Wed, 15 Feb 2023 23:00:25 +0000 (GMT)
Received: from sig-9-65-193-223.ibm.com (unknown [9.65.193.223])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 15 Feb 2023 23:00:25 +0000 (GMT)
Message-ID: <d1a172b7e5c4c09777a4dbbd5ff0f6c6e4c68160.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils 0/3] CI: Tumbleweed openSSL fix
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Cc:     dmitry.kasatkin@gmail.com, vt@altlinux.org, stefanb@linux.ibm.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 15 Feb 2023 18:00:24 -0500
In-Reply-To: <Y+v2synszNf1MRn/@pevik>
References: <20230214210035.585395-1-pvorel@suse.cz>
         <Y+v2synszNf1MRn/@pevik>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: K5kGS9iTNheHYHWIX2lDOEaHOnPXMXL4
X-Proofpoint-GUID: 4Y3okrukuOnfAOjsW2V5pedcrT0IDmvI
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_13,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150194
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

On Tue, 2023-02-14 at 22:01 +0100, Petr Vorel wrote:
> > Tested:
> > https://github.com/pevik/ima-evm-utils/actions/runs/4177976359/jobs/7236222413
> 
> NOTE: I cannot test this on Travis.

Thanks, it works on Travis.

-- 
Mimi

