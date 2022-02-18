Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73DC4BBD6C
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Feb 2022 17:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237755AbiBRQ1o (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Feb 2022 11:27:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbiBRQ1n (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Feb 2022 11:27:43 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579F8381;
        Fri, 18 Feb 2022 08:27:26 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IGHRj2012784;
        Fri, 18 Feb 2022 16:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=CAf3/8g98yoBYHSZHu69/QxNQX7XhJeI+AifvhOaMBw=;
 b=bnn9SviGbOWQCDP3rJ+1IHlMU83cQGvdtjDiVz0qRcZ0q80iWrZTupLPgoUS81Ow6sjx
 ldqbxlQWKL3eiqYAG6BEv+KPPeOuzT6mR7kRVnirlTzQqt6eQJ2Algb4ladq3NNADcVv
 JX/YQ7fOfPwhKy3X/lb8KLECY4TbwkbUO97piA+/qwBkt21r1C5um1yl/FS1KSxOgUew
 gyac8zXhCh0Vrz4atTyZj6nG6rE6HaifXR1d6sYKJMmXZ1jKxIukOPJpleUsoZRWTw8t
 mmV24nmBxArzMM/dQBvwJfI6IvM4cYBUVzQ7xIDYhDGlvBc/mBcoa4fSYKM7aI+CHqba 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eaeumr6dd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Feb 2022 16:26:56 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21IGMlcM001702;
        Fri, 18 Feb 2022 16:26:55 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eaeumr6cq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Feb 2022 16:26:55 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21IGK1Mr013981;
        Fri, 18 Feb 2022 16:26:53 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3e64hau7a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Feb 2022 16:26:52 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21IGQnkS38535558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 16:26:49 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98B3011C052;
        Fri, 18 Feb 2022 16:26:49 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D58A11C058;
        Fri, 18 Feb 2022 16:26:47 +0000 (GMT)
Received: from sig-9-65-84-246.ibm.com (unknown [9.65.84.246])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Feb 2022 16:26:47 +0000 (GMT)
Message-ID: <710ac626c18b8a98898d993a0f7c0a2349d2d7d0.camel@linux.ibm.com>
Subject: Re: [PATCH v10 14/27] userns: Add pointer to ima_namespace to
 user_namespace
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
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Fri, 18 Feb 2022 11:26:46 -0500
In-Reply-To: <20220201203735.164593-15-stefanb@linux.ibm.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
         <20220201203735.164593-15-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Vh64_pqutMbKrW4aRwGiwToQtTVtXJiC
X-Proofpoint-GUID: fZNxxpXgFO2y-FkRrPMjcLC6WU-rZX7G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-18_06,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180104
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan,

On Tue, 2022-02-01 at 15:37 -0500, Stefan Berger wrote:
> Add a pointer to ima_namespace to the user_namespace and initialize
> the init_user_ns with a pointer to init_ima_ns.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

The patch description explains 'what' is being done, but not 'why'. 
Please add a sentence before what you have providing the motivation.

Otherwise,

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

-- 
thanks,

Mimi

