Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CBF578FC5
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Jul 2022 03:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiGSBTK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 18 Jul 2022 21:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbiGSBTB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Jul 2022 21:19:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7350511C10
        for <linux-integrity@vger.kernel.org>; Mon, 18 Jul 2022 18:18:44 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26J1HTFF028927;
        Tue, 19 Jul 2022 01:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=rAe1g563z/EokgKy0Tfk+FodaifKPAaPJpRgIfZyq7A=;
 b=RG7o0hgdTZepGAKTRAdwTrbLb5oFyS0fxOkMH3PkSysFy8CmXcjWjlmaJ3mMzxEiXj4k
 CdV9dvfLtw0je4KuZJaMmwVkNHmQNKA7eZhqD3wDbNUfZIg1ztBtbZDJ9pErmG2nM3Yk
 4tXWF2nTDjJnrNScHoNd/fgkxoP/QR3451eUqkbYnrNXMvzg5iTW4a1xug+Q9WzhZObU
 IwLdbHlQAFU/5/QyHXeP8m128srMSqucwoKXaJKKDFC6vvhyltYyT+g+JPkQaO7qsx6h
 lSItpjfz0gT1kBp/hmnL3iUPlERxsk1n6qIUsECXDlRSn9CnHPLkDnVQf0bB5qaZXVYf Cw== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hdjtfr0hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 01:18:40 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26J16X0M023103;
        Tue, 19 Jul 2022 01:18:38 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3hbmy8jgdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 01:18:38 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26J1GqkJ18743666
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 01:16:52 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACA8611C052;
        Tue, 19 Jul 2022 01:18:35 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE2A411C05B;
        Tue, 19 Jul 2022 01:18:34 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.43.29])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 19 Jul 2022 01:18:34 +0000 (GMT)
Message-ID: <75c9600bb9846dc9b0a88e9e3956bc7359e80ce9.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] ci/alpine.sh: Install bash
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Date:   Mon, 18 Jul 2022 21:18:33 -0400
In-Reply-To: <20220715073121.8979-1-pvorel@suse.cz>
References: <20220715073121.8979-1-pvorel@suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 70LbAZ76K6NiXfcMGgL5C2UX2PuRcrrY
X-Proofpoint-ORIG-GUID: 70LbAZ76K6NiXfcMGgL5C2UX2PuRcrrY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1015 suspectscore=0 mlxlogscore=901 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207190003
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-07-15 at 09:31 +0200, Petr Vorel wrote:
> bash is a dependency for tests, not being installed by default on
> containers.
> 
> This fixes:
> ../test-driver: line 112: ./ima_hash.test: not found
> ../test-driver: line 112: ./sign_verify.test: not found
> ../test-driver: line 112: ./boot_aggregate.test: not found
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Thanks, Petr!

