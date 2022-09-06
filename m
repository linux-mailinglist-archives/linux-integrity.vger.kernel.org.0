Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CA25AF391
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Sep 2022 20:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiIFS1p (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Sep 2022 14:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiIFS1o (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Sep 2022 14:27:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42ABA2235
        for <linux-integrity@vger.kernel.org>; Tue,  6 Sep 2022 11:27:43 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286HTgWS019909;
        Tue, 6 Sep 2022 18:27:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=XQdraFDiZE2Ips9SH+G0AXlwbh9I/9Ta4IlsQiVuMiQ=;
 b=XGE8C1KeSqHa9YEEKsePwpygBCGoGzitL5fa8KKpLmQCOaasoOwcY8YXgv1FoNxgTOM8
 O+WAMWdpolMVm2XsNA4IoFnXRafSbS2WBORW7FueOEgwTA0BGtYFOUO1aqvG+ostIRj2
 LOgS64ezRg+/UjrtWjRTs3vuwwcU9x5zXi0XuaW3W28Wnv4fuyCWF+y1AcI1EJed0NcM
 6OODCUk+p9QnQTL06kZfYkaf8nkdBsev8PuEtjgiZz43YVjsZBmgihPoP3Vm8On8jOPa
 DBZojNU8YD/xSQ6f5Zl2E4CLQo/nZBx5Mc1yAj6cImH59VhYENAcc9TWlJrdovEnoZka 6w== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jeaf0j0b7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 18:27:39 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 286IKPOR025080;
        Tue, 6 Sep 2022 18:27:38 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 3jbxjaade8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 18:27:38 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 286IRbjv63242578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Sep 2022 18:27:38 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB8DC136053;
        Tue,  6 Sep 2022 18:27:36 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A24A13604F;
        Tue,  6 Sep 2022 18:27:36 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.107.58])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  6 Sep 2022 18:27:36 +0000 (GMT)
Message-ID: <cbd5ec45625bd111e5be066d54ffb641f417552b.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils 02/11] travis: update dist=focal
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>
Date:   Tue, 06 Sep 2022 14:27:36 -0400
In-Reply-To: <4e531d80-0df0-8f1a-6897-7e82a899ad9f@linux.ibm.com>
References: <20220902162836.554839-1-zohar@linux.ibm.com>
         <20220902162836.554839-3-zohar@linux.ibm.com>
         <4e531d80-0df0-8f1a-6897-7e82a899ad9f@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EjBfh5kuoK_ZmPT41bdxID7L-VQWFt3Z
X-Proofpoint-GUID: EjBfh5kuoK_ZmPT41bdxID7L-VQWFt3Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 mlxlogscore=945 bulkscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060084
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-09-02 at 16:24 -0400, Stefan Berger wrote:
> 
> On 9/2/22 12:28, Mimi Zohar wrote:
> > Although Github Actions is available on Github Enterprise Server 3.x
> > single server edition, as well as the unpaid version, it is not
> > available in Github Enterprise Server 3.x cluster edition[1].  Continue
> > to support travis.
> 
> This text really has nothing obvious to do with the upgrade to focal...

True, but I've been asked why we have both github actions and travis.  
This was a convienent place for providing that explanation.

Mimi

