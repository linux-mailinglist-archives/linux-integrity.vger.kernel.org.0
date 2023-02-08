Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C7F68F969
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Feb 2023 22:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjBHVDg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Feb 2023 16:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjBHVDd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Feb 2023 16:03:33 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BD54955E;
        Wed,  8 Feb 2023 13:03:13 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318Kd0us026549;
        Wed, 8 Feb 2023 21:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Ld1y4xvWUNg4hh071P3AIQ7o90DO8qMtLNahWE+XZ/c=;
 b=BPUOtAoUozo+tAZ/nYzBkflKQTRNF0JbBkNXLOyLVcIjChI87TCaAhR3qtP/6oTiosk/
 80weFN5kZDapO37kfe0regTqLPDF08LW0xMGi4r0Rqi8hTXWsXniODXAlgpZDa0kiBaK
 VVtA20gYFrWyve4kdbHNFlGqD7eOzwxZE/koAmfnPPhQdWAdkqX3Hrk9AmElVt2DDPi8
 d6u5C56f1MacMSNnF9iWTMQWNmwdSjbJGpZuRRF0AdvWiCeKZ1ZRx4vncduiJ5zUTTVN
 Z2qv8Rgf/bKnog4zhCojzbASVPcSy+lR/28FuJS+R1DuTSYRDbZkpPxoqhtK7ML3RLFP dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nmjjg8wkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 21:02:19 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 318Kp7AI027930;
        Wed, 8 Feb 2023 21:02:18 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nmjjg8wjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 21:02:18 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 318JSexS020153;
        Wed, 8 Feb 2023 21:02:16 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3nhf07f6by-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 21:02:16 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 318L2F7o7275094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Feb 2023 21:02:15 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35F8358059;
        Wed,  8 Feb 2023 21:02:15 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 221B85804B;
        Wed,  8 Feb 2023 21:02:13 +0000 (GMT)
Received: from sig-9-65-211-196.ibm.com (unknown [9.65.211.196])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Feb 2023 21:02:13 +0000 (GMT)
Message-ID: <b3965b3392d799a04848ab72d4eb5cdeb9736253.camel@linux.ibm.com>
Subject: Re: [PATCH v4 4/6] KEYS: X.509: Parse Key Usage
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, jarkko@kernel.org,
        dhowells@redhat.com, dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, tadeusz.struk@intel.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        erpalmer@linux.vnet.ibm.com, coxu@redhat.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Wed, 08 Feb 2023 16:02:12 -0500
In-Reply-To: <20230207025958.974056-5-eric.snowberg@oracle.com>
References: <20230207025958.974056-1-eric.snowberg@oracle.com>
         <20230207025958.974056-5-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -NRkau411-dqyK-BRLgzcx0sxM9431rl
X-Proofpoint-ORIG-GUID: O2imsdfnjt1YK5PJ1v-IVI6ACXy68YxX
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_09,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302080178
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-02-06 at 21:59 -0500, Eric Snowberg wrote:
> Parse the X.509 Key Usage.  The key usage extension defines the purpose of
> the key contained in the certificate.
> 
>    id-ce-keyUsage OBJECT IDENTIFIER ::=  { id-ce 15 }
> 
>       KeyUsage ::= BIT STRING {
>            digitalSignature        (0),
>            contentCommitment       (1),
>            keyEncipherment         (2),
>            dataEncipherment        (3),
>            keyAgreement            (4),
>            keyCertSign             (5),
>            cRLSign                 (6),
>            encipherOnly            (7),
>            decipherOnly            (8) }
> 
> If the keyCertSign or digitalSignature is set, store it in the
> public_key structure.  This will be used in a follow on patch that
> requires knowing the certificate key usage type.
> 
> Link: https://www.rfc-editor.org/rfc/rfc5280#section-4.2.1.3
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

