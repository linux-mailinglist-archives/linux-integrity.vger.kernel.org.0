Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD41877D429
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Aug 2023 22:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238055AbjHOUby (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Aug 2023 16:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237837AbjHOUbV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Aug 2023 16:31:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941331BF0;
        Tue, 15 Aug 2023 13:31:14 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FKRhBl019876;
        Tue, 15 Aug 2023 20:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=l8eaVAtIzk7e62x4m+EROozGwJIj8lDVod4vW7iHGWc=;
 b=XaImgLvSSYxs8xR1h9Gr82KL3Dhfi++JbAjOeHez2Fr0w7y2/LcX9RIb/ug3zo+78ZKZ
 1VA6Lfyk4sm8Y539PMhmf/lrOUemduQliH3YROCHHzTbd1102sLLTjY+HJLwVXHsN8OT
 G/etvqzSZ9iGKh+9dlGsod0Qki2D5fgJLCA4pycQX/MfmI6o3QgdWR7i+aIiuBF8XcHn
 2mKPbSNfxfMaMF2q4PyIZmbJSDRmbbG8AeapwYxlAsagstIc4vbGzMK3dfVSdbdulGGe
 WmexPeZQUkG4CxAZr3O/GTpppHdJyzSCFwOdy+Rm/YaNplyDLzG0qvL/e5mMfnMw5GXH Vw== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sggdqg1s9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 20:31:01 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37FJ6EgX013413;
        Tue, 15 Aug 2023 20:31:00 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sepmjq472-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 20:31:00 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37FKV0De64684426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 20:31:00 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED1E058062;
        Tue, 15 Aug 2023 20:30:59 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FFEF5805C;
        Tue, 15 Aug 2023 20:30:59 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.88.161])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 15 Aug 2023 20:30:59 +0000 (GMT)
Message-ID: <5f0bfbfac70978726fbc88891ad0410514b76397.camel@linux.ibm.com>
Subject: Re: [PATCH v4 6/6] integrity: PowerVM support for loading third
 party code signing keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-security-module@vger.kernel.org, inux-kernel@vger.kernel.org
Date:   Tue, 15 Aug 2023 16:30:58 -0400
In-Reply-To: <20230815112722.1591829-7-nayna@linux.ibm.com>
References: <20230815112722.1591829-1-nayna@linux.ibm.com>
         <20230815112722.1591829-7-nayna@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: noj0xbLhBk11GmQZtRJ1jF19W9c4HqwC
X-Proofpoint-GUID: noj0xbLhBk11GmQZtRJ1jF19W9c4HqwC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_19,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1011
 mlxscore=0 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150181
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-08-15 at 07:27 -0400, Nayna Jain wrote:
> On secure boot enabled PowerVM LPAR, third party code signing keys are
> needed during early boot to verify signed third party modules. These
> third party keys are stored in moduledb object in the Platform
> KeyStore (PKS).
> 
> Load third party code signing keys onto .secondary_trusted_keys keyring.
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>

Reviewed-and-tested-by: Mimi Zohar <zohar@linux.ibm.com>

