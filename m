Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC19705C3F
	for <lists+linux-integrity@lfdr.de>; Wed, 17 May 2023 03:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjEQBSo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 May 2023 21:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjEQBSn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 May 2023 21:18:43 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B5646B6;
        Tue, 16 May 2023 18:18:42 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34H19tTM004739;
        Wed, 17 May 2023 01:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=dAlxTcV2nWWwtGGEUKmuwt6if+L/fira5WMfuLlT1Ig=;
 b=evy7AinO5+qGK44djUUlUoqTeFFv9724ONNZKSM4RYBDv5HdShT8mK+d5YUplVASvnss
 csiLFQMnVzCEv1tjfbVhgxlBMqxLCAJNIdGOpHJauOKHmlunKPBIfXbNRLI0knb86Pjb
 iG5YQHzaN5Cz/v6rxYKZUSo0XLXw/5GmSR7GDZ24F103c9ddOR04FQTRYZ0VLEaJ2JSY
 QwXsj0APrP6qQe17/ZIa9R/jGECunj/6Go4Csqad8Id+3DYZfCNfIoTOhHWWtVUKmicy
 RSCYkFp+D7W/XwwaFX6/wX0W3A1E6wa79jiYF6JmYbxk3d2UjjkeqOc+iX/ahrbcdo7i /A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qmkfd1xxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 01:18:28 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34H1HkmV028223;
        Wed, 17 May 2023 01:18:27 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qmkfd1xxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 01:18:27 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34H0P5vp010793;
        Wed, 17 May 2023 01:18:26 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3qj265yxn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 01:18:26 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34H1IPoI28705410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 01:18:25 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F46658053;
        Wed, 17 May 2023 01:18:25 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AA1258043;
        Wed, 17 May 2023 01:18:23 +0000 (GMT)
Received: from sig-9-77-133-203.ibm.com (unknown [9.77.133.203])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 17 May 2023 01:18:23 +0000 (GMT)
Message-ID: <06dc2a4ba78fdf9512db753df92facbd37ecbc25.camel@linux.ibm.com>
Subject: Re: [PATCH 2/3] integrity: Enforce digitalSignature usage in the
 ima and evm keyrings
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, jlee@suse.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Tue, 16 May 2023 21:18:22 -0400
In-Reply-To: <20230508220708.2888510-3-eric.snowberg@oracle.com>
References: <20230508220708.2888510-1-eric.snowberg@oracle.com>
         <20230508220708.2888510-3-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Sn5glUSPreR2AenhXQO7GDKlNhp5YGKn
X-Proofpoint-GUID: m-obeoqEfdZWmFvT1egyKRtF5yyCJWbG
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170006
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-05-08 at 18:07 -0400, Eric Snowberg wrote:
> After being vouched for by a system keyring, only allow keys into the .ima
> and .evm keyrings that have the digitalSignature usage field set.
> 
> Link: https://lore.kernel.org/all/41dffdaeb7eb7840f7e38bc691fbda836635c9f9.camel@linux.ibm.com
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Acked-by: Mimi Zohar <zohar@linux.ibm.com>

