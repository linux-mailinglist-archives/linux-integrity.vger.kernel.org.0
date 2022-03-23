Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165AB4E51FA
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Mar 2022 13:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiCWMPn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Mar 2022 08:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiCWMPn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Mar 2022 08:15:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9E6387B6
        for <linux-integrity@vger.kernel.org>; Wed, 23 Mar 2022 05:14:14 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22NBmuQY000719;
        Wed, 23 Mar 2022 12:14:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=o/wM4vzGq8dTupNActqr08WXpNOISpzAI0r9vAjXMpk=;
 b=IDtRhvsH0I/taLURPk49IL8o/xqKbMdfvkVGdAbdghusyHt2F1/4cHDX6bWMwp2/4PM8
 HTBcSli74NjaWOWDtO5w2PwsPlO5JPLCNvzf98Ovrpa9XR74ydJC9CgsS2RHXCYuv9j9
 OnK2x4RzadwcNvXBJDzuRt3WrGUZ8oD4i83OkHfiZI6qdK/j5d8KkxapWagzvDV02d7J
 3E2tvTrYLKpZW4E3e4CIcJVzsYdCEWShDucfos0wrWwkARh1Hhq6tq9QcUqr4fUuIF2g
 HzALMgiGjNgZlW0DV3BxiE2dh9jx0x76WsEBWnJq3gNt7cAvnqrXdFoc7aFIDoVkNspy Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f000ymg96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Mar 2022 12:14:11 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22NBxE8h025778;
        Wed, 23 Mar 2022 12:14:10 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f000ymg8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Mar 2022 12:14:10 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22NC2sA1010171;
        Wed, 23 Mar 2022 12:14:08 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3ew6ej0jby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Mar 2022 12:14:08 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22NCEABR22675922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Mar 2022 12:14:10 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23C1A52050;
        Wed, 23 Mar 2022 12:14:06 +0000 (GMT)
Received: from sig-9-65-73-171.ibm.com (unknown [9.65.73.171])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 51FAC52051;
        Wed, 23 Mar 2022 12:14:05 +0000 (GMT)
Message-ID: <8c8dc78ab91d41c5755b5e1ae13a3054816d8072.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] ci: Remove CentOS 8
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-integrity@vger.kernel.org,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>
Date:   Wed, 23 Mar 2022 08:14:04 -0400
In-Reply-To: <Yjoj6VZzLtOydw0f@pevik>
References: <20220215074958.6942-1-pvorel@suse.cz>
         <401a1ee927a68a7c0811f21f4e75b6f01956e59c.camel@linux.ibm.com>
         <Yjoj6VZzLtOydw0f@pevik>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6C3JaP2_jXsQoqtt5lifcWJemhvGVvRN
X-Proofpoint-GUID: cm0GB7vTSI0e6yyKKl4c84glmO4TBKhK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-23_06,2022-03-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=966 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203230069
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

> > Removing "centos:latest" works, but is there another option?  Perhaps
> > defining a different repo - "REPO=quay.io/centos/"?
> This fix would be for Travis, which I'm not able to fix, but not for GitHub
> Actions :(. I'm not aware how to specify alternative repository for it.

FYI, "centos:stream9" results in crypto deprecated warnings and results
in /dev/null errors.  Instead of removing the "centos:latest" entry in
travis, I'll replace it with "centos:stream8" for now.

The "centos:stream9" -devel rpm packages are in the CRB repo.  I
manually set the CRB repo to enabled using sed.  Is there a better way
of enabling CRB?

Do you prefer to limit this patch to just removing the "centos:latest"
entry in ci.yml and reposting it, or should I trim it?

thanks,

Mimi

