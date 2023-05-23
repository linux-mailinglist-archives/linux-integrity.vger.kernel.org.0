Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7EB70E88C
	for <lists+linux-integrity@lfdr.de>; Wed, 24 May 2023 00:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238727AbjEWWBn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 May 2023 18:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238684AbjEWWBg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 18:01:36 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772C3119;
        Tue, 23 May 2023 15:01:33 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NLeXva016075;
        Tue, 23 May 2023 22:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=MdVU7abtXulrEmZvk8hyWbh1EIfcnDPCWt6GV2QF+2c=;
 b=BH2lk5tycSEujzy2FrnMHTfZBtop2L60Odrx3mz7NDvgQNCORwYRpdB7UV9QMjX9ghsO
 7hTICzBIzHXoAeV9/3voF7zBeluX9Cx+qixtZUILy2hq+gJO3kMpnWooyJM/RsvK7WKy
 tzkP15EZ358yW8w/zE1yHD71onMI/XkpbBa3zJ0wgncb6g9gObhfORaAqsWLrvxfn+8q
 lrGSo3t2+ukjCLDEcIaDS7JC+n9/3VhPEkg6iY7p+eMKiRgPa9QCDb+J4oH63RtrKGq7
 NhOzKM0qaFwM8FAabIx6/XmhYNM871CgZhNYk5s80sG9yTMSlZdSKRA1CwbVRnhas55+ lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qs58egpva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 22:01:10 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34NLgs6r023317;
        Tue, 23 May 2023 22:01:09 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qs58egpuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 22:01:09 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34NJVPBp010693;
        Tue, 23 May 2023 22:01:08 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3qppds14jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 22:01:08 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34NM171i43450848
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 22:01:07 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C571758052;
        Tue, 23 May 2023 22:01:07 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C03B458056;
        Tue, 23 May 2023 22:01:06 +0000 (GMT)
Received: from wecm-9-67-154-32.wecm.ibm.com (unknown [9.67.154.32])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 23 May 2023 22:01:06 +0000 (GMT)
Message-ID: <ce525793452831d5823bf0548faa0eae2a302f5a.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/3] integrity: Enforce digitalSignature usage in the
 ima and evm keyrings
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, jarkko@kernel.org,
        dhowells@redhat.com, dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, jlee@suse.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Tue, 23 May 2023 18:01:06 -0400
In-Reply-To: <20230522230944.180389-3-eric.snowberg@oracle.com>
References: <20230522230944.180389-1-eric.snowberg@oracle.com>
         <20230522230944.180389-3-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SHw82eTQXYpIMUEbFUBIN9dv5kAS2JKH
X-Proofpoint-GUID: 8BM7Mr42F2lcnQ4Q_BbE362-sR41SRod
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_14,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230173
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-05-22 at 19:09 -0400, Eric Snowberg wrote:
> After being vouched for by a system keyring, only allow keys into the .ima
> and .evm keyrings that have the digitalSignature usage field set.
> 
> Link: https://lore.kernel.org/all/41dffdaeb7eb7840f7e38bc691fbda836635c9f9.camel@linux.ibm.com
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> Acked-by: Mimi Zohar <zohar@linux.ibm.com>

Jarrko, similarly please update the above tag to Acked-and-test-by.
-- 
thanks,

Mimi

