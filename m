Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BD84E45F5
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Mar 2022 19:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240512AbiCVS1a (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Mar 2022 14:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240538AbiCVS1G (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Mar 2022 14:27:06 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1140D91349
        for <linux-integrity@vger.kernel.org>; Tue, 22 Mar 2022 11:25:26 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22MHlufe020577;
        Tue, 22 Mar 2022 18:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=WHSY4fz+3A9hxbGx63CiJzrwZOhCEVEt9+qNTBBTwZQ=;
 b=AbN7c13CBF4T/WKA79WVnJhw088jT8QHGD5fqYeRjrtdQh3SSsPHXJ9mcv7XTGGJ5cyS
 zTMmlKXhrnS6J+I2ZfYdZOyKiqDh5HGldR8fuqoV0RHY4LkwvsCXNLoJOX6lVF2R85ia
 ctsx6Fvvusc3YFuXPoUyqCPp9K9Fizd3sIWWzR/sKiLJfcwTCxlYuakydxJCml00TeYb
 oBitMq7W/Ny7cYvyyXCaYcEEEiv7W8fwPkwoMeoBAGfxQK8DXtjD5vgmbnv0JncRGmcZ
 /LwKLfVg9HZ5l77YsvBy8m7zrKGX45oX/aNi/70kkfqQvLzhzu4HlFEVHlUwBwhMZUV/ +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eyautwh9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 18:25:22 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22MHu1sB025715;
        Tue, 22 Mar 2022 18:25:22 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eyautwh8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 18:25:22 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22MICJx5027159;
        Tue, 22 Mar 2022 18:25:20 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3ew6t9du38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 18:25:20 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22MIPIPE51380564
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 18:25:18 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5451F42047;
        Tue, 22 Mar 2022 18:25:18 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9037C42045;
        Tue, 22 Mar 2022 18:25:17 +0000 (GMT)
Received: from sig-9-65-81-246.ibm.com (unknown [9.65.81.246])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 22 Mar 2022 18:25:17 +0000 (GMT)
Message-ID: <401a1ee927a68a7c0811f21f4e75b6f01956e59c.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] ci: Remove CentOS 8
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Cc:     "Bruno E. O. Meneguele" <bmeneg@redhat.com>
Date:   Tue, 22 Mar 2022 14:25:17 -0400
In-Reply-To: <20220215074958.6942-1-pvorel@suse.cz>
References: <20220215074958.6942-1-pvorel@suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nSKys16_OqZ383dmfP2AiGr9vOL2Jms0
X-Proofpoint-ORIG-GUID: 0iCC6olhRutr-N-2EZZRhOsLJz5MO3wS
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-22_07,2022-03-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203220095
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

On Tue, 2022-02-15 at 08:49 +0100, Petr Vorel wrote:
> It EOL in 12/2021 and CI is failing due removed repo:
> 
> CentOS Linux 8 - AppStream                      232  B/s |  38  B     00:00
> Error: Failed to download metadata for repo 'appstream': Cannot prepare internal mirrorlist: No URLs in mirrorlist
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
> 
> the error:
> https://github.com/pevik/ima-evm-utils/runs/5196409185?check_suite_focus=true
> 
> Mimi, could you please test Travis CI?
> I tested only GitHub Actions:
> https://github.com/pevik/ima-evm-utils/actions/runs/1845623174

Removing "centos:latest" works, but is there another option?  Perhaps
defining a different repo - "REPO=quay.io/centos/"?

thanks,

Mimi

