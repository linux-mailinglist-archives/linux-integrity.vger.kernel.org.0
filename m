Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E306B7A61
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Mar 2023 15:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjCMOdL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Mar 2023 10:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjCMOdG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Mar 2023 10:33:06 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30201BBB7;
        Mon, 13 Mar 2023 07:33:02 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DDw8fL020315;
        Mon, 13 Mar 2023 14:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=EB0cwcFCZq1QLZZYrEEn68+CuFIz0tlLaFF5ULkdTrk=;
 b=f21UmAlv7MrKkKkvYFQWyRSm+St/EO8iiq0Sv7VRtq5QYNWajhG1TENN2hPgxZR64Hfv
 rQ4pCLqiiOapWqbo4GkUxKlp2Spkz9CU2KyjLHiUsOqaOb1j++jEvqc+a52V/AALd60a
 9GIbberPbVQklB6jvPQtReFHHzowO0pd3naWhp/4jLJO4NHGLS4KmStwvypfnzJ63anr
 CbZZ9vqWP2mceT0f8RJjrn01xGng0SOysxSLU9ubaM4YM/ElViacKZM3Ul9e3eq+Hla1
 7+W5F5liGaCuviypPNac/vjP+vGfPCs6wjthgmvfYz0wo4qMpuwmSzCJKWfGc00zA/LA SQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pa3sbupxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 14:27:03 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32DCMJdB020816;
        Mon, 13 Mar 2023 14:27:02 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pa3sbupx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 14:27:02 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32DDwa9Z008599;
        Mon, 13 Mar 2023 14:27:01 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3p8h96x5d0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 14:27:01 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32DER01f37355910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 14:27:00 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84B9C5805C;
        Mon, 13 Mar 2023 14:27:00 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A26A5805A;
        Mon, 13 Mar 2023 14:26:59 +0000 (GMT)
Received: from sig-9-77-159-147.ibm.com (unknown [9.77.159.147])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 13 Mar 2023 14:26:59 +0000 (GMT)
Message-ID: <32ec16c9c3caa731c3de69371de6318da7f7ea91.camel@linux.ibm.com>
Subject: Re: [PATCH v5 6/6] integrity: machine keyring CA configuration
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, jarkko@kernel.org,
        dhowells@redhat.com, dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, erpalmer@linux.vnet.ibm.com,
        coxu@redhat.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Mon, 13 Mar 2023 10:26:47 -0400
In-Reply-To: <20230302164652.83571-7-eric.snowberg@oracle.com>
References: <20230302164652.83571-1-eric.snowberg@oracle.com>
         <20230302164652.83571-7-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AVn6e_N1RxRLy5krPqhqwYoTOHO05acB
X-Proofpoint-GUID: Ns97NCTx73M2atYukwJYoFiNIAEjPIeb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_06,2023-03-13_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303130112
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-03-02 at 11:46 -0500, Eric Snowberg wrote:
> Add machine keyring CA restriction options to control the type of
> keys that may be added to it. The motivation is separation of
> certificate signing from code signing keys. Subsquent work will
> limit certificates being loaded into the IMA keyring to code
> signing keys used for signature verification.
> 
> When no restrictions are selected, all Machine Owner Keys (MOK) are added
> to the machine keyring.  When CONFIG_INTEGRITY_CA_MACHINE_KEYRING is
> selected, the CA bit must be true.  Also the key usage must contain
> keyCertSign, any other usage field may be set as well.
> 
> When CONFIG_INTEGRITY_CA_MACHINE_KEYRING_MAX is selected, the CA bit must
> be true. Also the key usage must contain keyCertSign and the
> digitialSignature usage may not be set.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Thanks, Eric.

Acked-by: Mimi Zohar <zohar@linux.ibm.com>

