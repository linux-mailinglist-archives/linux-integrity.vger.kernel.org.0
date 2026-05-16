Return-Path: <linux-integrity+bounces-9587-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCd2DAeMCGohuwMAu9opvQ
	(envelope-from <linux-integrity+bounces-9587-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 16 May 2026 17:23:51 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0C855C52D
	for <lists+linux-integrity@lfdr.de>; Sat, 16 May 2026 17:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1CF9300EAB9
	for <lists+linux-integrity@lfdr.de>; Sat, 16 May 2026 15:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FA13A3E73;
	Sat, 16 May 2026 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.us header.i=len.bao@gmx.us header.b="VizOfTUJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3528C3E3C59;
	Sat, 16 May 2026 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778945003; cv=none; b=d9bUtToHk1fogep8KnaJk9SQiAMFV4ABNYbybtrLj9RLQ6fQc8XF752/uFuBHWzhnI/eyWx1SPzx19UMdC9MraLqPWX2/ZZcHAJnQ1/NtrPZrk/g+IhEZ2KAu3JE1Ml2Nztjn0lxB9M1ZgbPVIEtl2PMVJz71vMOFekTmhQBjgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778945003; c=relaxed/simple;
	bh=AMPt2Opsx1Qcvut9w/XuBiufSBpKYV1Bw/QS6GomWkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MVw3cZ+XG70blGMCeyIWW34S71v2fBQAOlblvv/pAMyf1NfGBzam7JNoCNr5SBvaouF+kEc3FREn3rtWc3SCNlD3KySHJZRD5q454X2LXGI+ZPqwxiFgvK0UtVugQHwPC5qOiNXpkDdfse9bFpRosAvm0peQ798wLTH47LAxIos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.us; spf=pass smtp.mailfrom=gmx.us; dkim=pass (2048-bit key) header.d=gmx.us header.i=len.bao@gmx.us header.b=VizOfTUJ; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.us
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.us;
	s=s31663417; t=1778944999; x=1779549799; i=len.bao@gmx.us;
	bh=OlDVaQiVAv4LonFHoh8IBv9FleSYpWSLLMGDOXEebZk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VizOfTUJaAIul7j0ZUo7lXeFKNgdQYLOG1/+4noyIPgbGY5zJyuTSkKByggrkR67
	 59G91CYcg90BWvjfa9Y5TAhVQqbBc9Vg41uFX2+sN1D/g3GNIUf/n1mEhDP6ZK2cF
	 BLbBZJ4o4TO6PBU5EHqA38woj5hDbTLE71wqFryT+hkaD+PD9I9Z37EwsGYc7avB/
	 9DpdCFeq6GIL6ydWQ6cfg9LbK26WgmckPkEzSci7mdrDncGRdTe6EbC2AlIxDUkDA
	 fmu5OshKf6zUxXAPc83KcAsx/gRIo8A4jwe5MfmcMKIlkmScnnLb4wbmOaomPRiYK
	 sOQ8EA3eTkS8jldwJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MRTNF-1wljWs07gD-00TeDX; Sat, 16
 May 2026 17:23:19 +0200
From: Len Bao <len.bao@gmx.us>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Len Bao <len.bao@gmx.us>,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] keys/trusted_keys: mark 'migratable' as __ro_after_init
Date: Sat, 16 May 2026 15:22:47 +0000
Message-ID: <20260516152249.41851-1-len.bao@gmx.us>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FQzpIx/Y3nw5KpiKdweU5V3vM0sz7Bh+mQvUvGBIXRwjpK7d1Dp
 ldWiavXKbZ/LMk/IvgzMCCairrw1bjb0FsPaaZrgHMNCintbvKp/RU8/AUMPxhPGnMmDlTy
 vK/85eaKPRv/aXgtotMBR8HCv2z2gYmOLQmAAHw69c38VDD2etiLJo9FT1WS0/tNifcmIst
 xd09i1LbC22d03s/Uugjw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LQ1Ab4yqilY=;YVggcY4DOfftjAS2HfeFc02B3rZ
 FzQ+S/6/0hPfN3mglqzZn75HO02LUjcpEa97iSG7l0J9uCEwNKI4k+De39Aa21zdApoWCeZyS
 arca50dHSrXlXceGjIOxqptPTpR6q89QW7fetY35/ydpmb8KbRfCY4H+16nKp229khVqemDxm
 jQvoNXKv2o0tD5ghJHHvwKUCVx6qpJdYNiYc73yI8Dfnu47M+BioO6BNQiY8sZRDFove6ICea
 FWZdd1NuPVgycoCTx5JNC7xQdQKRUpqp+IxMGMg29r0uUQWK00TJed76oB9OoX1EzBWxfs7ZM
 SIpM/hjANEi3FC0eOcuvKyV4sjrSVzvrBepolCmp6FmpzkOvKlR7Nsps2Gj/3OO+3cyTzKIoD
 EJtPs5zrvrlr/Twfib9jAWX2mgk1VwHwDR/KSvQDiVy3CyYl108RgCF2brZqwLNUWVDhu2lux
 bJrmSd/+TRZi2s0P6FQSDi4+fooRUF9iqkIM+tYuqZ/NUTg+J2IW8+/Fzdvlt13TIBxsW9Lpw
 tyUNz/2HG2+L5MFkIJ83ocImfXz+JlcExztBViwD86xTHGh5HDqum5uwJTaQjGur16lm8sG2n
 WRTTzQsdWAaX8i2e/9cUc7nNwNP+u/IGFo3T9WxLPU4QLCyFveKKWBNBvmBpIu0UGKBXWeExK
 UN4hlkeNfRu1ExeHlJbqVLbdsEzmtQRGdfCgCwBneLwcYQo0tDKppubavSvIsfdvJEDy7CiVv
 NklkOoMJQ3IGd2Zx6H4rrNWjn5MsS/u1/NhB6HrqvRDvgFiXCV6Mjj8uL/rsJdxQzMwZ3TapI
 rYEoV0lI1AJIGM2IN/t91KuoACzax2jZ2/BW0AJ+9aJNqJcxxiMW5oCWWl6rHIU/714L1/XQx
 pxAf+6dPGL/hzE7yJDR1YQ2VqVN7+k51tqZ0/e47HllX0nsA6uiaFSa0rBI8thcjYVDADVOqS
 rzPIFeyx4UCKCr50WvLseFL2M7FCj49bcnsBhriTogPc7gxhRcH0SXhpRUKTlPmiNSoMkl8MH
 YF1B06RX5s7q38PiyeK/jPlJ90WYWRALJIcy5IrTdr1B41XE7VrTe3BBpxJvYG+kxKCYqKbJO
 k2scvMcf0EFgDcRr0ejKKvojeWfFrNbr0cyEkoPrp0/e251j131xoM5gpWvzDExAoKWxsWm3m
 XbcqGyI++VSKZ+0ODMeSn9OZ/wIA5VpS9N2sFBfD4ZGUSUvKWjB7Glu5gLb5xsLULNhfivDSw
 XPFILw5tvvhichlPbXFbtMLnpuAo3i9leGQjtvORMgprGl9CiM15+iS3AJ0DqE+0jyT/u1yR6
 umPCkx2xczghK6oZBDk3IyT0C4FM1CfMGOlx0OlmnwSUIRf+m8RlcRNLTwDmvTLm5WV6xJ2Lu
 NwdAy0s1/5JNy9rSw7eH2QLTNpzrp7Ay6O/wqE/VzIXSZB/UBPyHt5Xx6wP917/4hlOyU7MK6
 sitEW21svJgZxkFxoZboaN7iXgMZkA0vXatdKFohs4LGfb4SIWZELmGkcY9eTsalLuWgjJOCn
 MGcCNg/VqsP+QOFj/qHamMVhgNMDaOZny5E5RMPidRR9BHAo+lH62ndtjnMP88atmKqaYSAD+
 70WCYl4pgI0Hun2vLDyIMOPIcu5BctAT5gA9qNqPDxLW/JqmKog3s7C6FHdotD0/p+8zv9d5O
 kToyUlV/v9E9Odx1a+Idl8UVbRxBt5JenHZNZxNpnDgGnH5HYGGlPy6oOd9sBPhkHPq9cwA92
 ndgp9PMSJbHyHfDqbzIGeqK2l6QOLIUJFZMc135DRhcVj+E12Np61VmraEyhugVuVh80KrhvS
 OjKGfL3y+Bs5mlpVsYt9+ChRA1iHLoiMj/RbhhbH6lzVs2oEOQP9DZXxcbNssC4oq21S9z3WN
 JVQUOYWlljV/Le/3HxV+UG2gNV5wfesvOvu2eVYcW/MVOEJ+LRNkm2yux9eg/WrVqLn/JdbLj
 s04iFGUl0bU/2oKSuYsvmG/BBewDjBWJvjnsPp9ODD4DOc749ppZvjNMzAjHI0ZvOO5fBTI3j
 wiDnPKuc0PgBYRLgePrVlq94tridMdxf5eWoU6WaZmGZXKe0DFsR93M37qs3l/1w+7jv7kQ4h
 undO8zyjywdJvAwVQrQK/eElLvSZ7P6aWFMTMBaVbwyRvDJeJwcwysEEUqTf+DbRGGh5GyRli
 UFdvjWWGhyAQXxQRv2ZTN807c1g6bC/NOmplL29HK10ubpevulBSSrJMIKDSw7uNtg306RZxV
 xDHlhs9jKOCR7sDE2XNnJX0GMwO0wQ5gtj+gamkfiam4L0mroMLrTcPQgyJ2jcMVjvnwDe4MY
 XyBkgTNLMFZGDWGsdFhmWcN1G4h6BPBw5kP6RWqkIXohpjhhhMRlN1CCRiD9qNpiZuRWGKL1e
 1iwIa9iaUDJttciJuuQOR6/RyaahKt2Raf8kVr15bZZ3UsG9iSTftbun6SbNAA7GD5B4suHfA
 k4oNLnoI/v2CjpoUNwWBA7HsPG14Hq8m6ZN1M/Z4pPlkB+8L++7RJTysjBLKVLvXVt8yll/hn
 KexvcfY/EdVrHYRKcVC+2dz4Zd99MqNTsL2G52kST+Vw3yANjJpW0D7EEl2PYTpywpZm7T82I
 M6/A2bsZjKIt6ihWLd3FQvJJUWjffblerRwgm+QljiFKTRLWivz/30X/SXdM3RqJNCPlUPnAc
 mnbbTJVWHQ0T7CysgIRsHVM11zcyRjzWasZyRYRF4X4eO3zTi8kvQcqPmX+XUsX9rqRjmMj8T
 ZpDjTUfMqZg29Vm6EK5gplPLl9NxhY0wrWXu941ds52crPleGRm1hSdO1BHp/AD6DQEXVxN9G
 w/Vcg9vFFPCHgSX67zALwVaY6yhYJluHdwcSED3lotHmZCfwcbS9dfWVMiwMvAyr2OucjUGUh
 WrTbO1sD/rAgiwzz0l7oXYS1ccv932nDndck850rw/Lqk5CM/hIJj4T7URL6Cb3GqDzs4h2WV
 L0kIzy27O61zMqhECxM55xnQpS7UlnbA90GTlg0TJllorqN7AAKxiMwj+/+fhzD1ecN8C8eUz
 I/BhaDhEDpl6A1DesmUgtqGZXdfz7nYt3OGMi/8h1Tyq3kHXKRAg6p9W3UbrEOwCn3QF/Hff7
 wd7vtyh6CQHXfwNmu3RXPRIDmclLuhyc41wRcwCiLaF3aDhAK5YTwA+s01Kl27ZEEpKKBuXo3
 SCpWSGkFzppPN5ym2GBTbZKEdGDBV1n6Hl2d9m+x5PK66n9F3GFG0FR29qogtDIBgsO5UEaru
 GoJ5YV605bEGBnclq+BktGjRlpFsrtskMeXqhpbdl03xnWiSqiNtUKL9dCMtOHNu8gRhnLyPS
 hqEn/dSowxbIDl9oG9Aenn6jxx2oLgluJ4GP2a954BJOR9Z+Fs1O+Ir2zcjRyxWb6S3zgjtKP
 WSVwpy9+zUp8sHST17aMC0Ds47niIs4xAa+G7Mh+r+hmdx4UBSkUzaZp28+88nbRj5/v6j+DA
 envhvRzPrYdlKF0uGC8Vs3bczRhM5DXF/DARJ+y+nJ89Wsm0fUUBHU46A2qpClhW0wT9XUYhC
 x1lmyF7x/r6GIQ/sShWkWnxSuUdHTOQe37OOYFEX//btI/wG3kwe7vYUCCRcUOs+6euglRyEf
 HrKPKl5SsWIXI2NhXVNueis3tLOsLta0MJ1q7xUCRG47vlEsuiZqAIfuM9YVZk+/+nTC/QcTs
 /cdXGMBZhj9IypeSYv3yEBtVbvHpu4CqQU/t3hGRcker4Eycvg6YT3j2A7LinAzGR06sbr+qx
 XCMls1u82dSBV4ccH9gqLggVa/v9Utnqc38pNPyJhzpHmolHdNR9JSdP0J1dxrHqTY1nP7x+T
 r1t54RQJ2Q0R9UmgBoqDTeOh/hT3CO0k2ub77Vhq8zgbdOj9CZFQKA1QfYPHBnRYN4HvvFP37
 q0n368ag2pQ0ik/d1eRAK13bnCFrtlOnR9v3oZBfBOMGWEM7mhkNiqv4MVp3L2TwDDFnIJj+G
 q5v0UkHokI/valNLCK6vYRjrkC782YbxoNvdNHuQV1YgTNK9MJmMq3F87FfhswtDIXHPMxHTQ
 A5xBVYYymB+EGxH8duX2h7QixAPnvHz96dZPY0ZnrSSsLtLRWEqy076RIianwdoWr9Yt4nwVo
 20nAah/GhCtg2YTQMfB5l/VnKlQ/cxgQ1CG4frEriz1UHRvjs36nxJY39eDoxqTZboTIqrutQ
 AZYAVnvHSNnvS1+mXPHlsjH9f4O5TuSRv/FwdVY+ZReyo/Tyzfnrex7QKReC5nbW0Z+AfqFD7
 dJKql0BDjnuL6SrkgaTAsD6zOhrwrC8K5sDo7uTQAmO/wXaEMvqteMOscUxHmer4FB2IAyKhh
 pv2Bx1vvq/b2s2ORVHk7cBLk27zb7hlwJLBPLZ0xO/xXRrWmY1xaIY4CO1vVAfVXt+kawSa+i
 /P4CKkkxN8HETuyZVQgXq4HZuU1NPgMGVnCUwGxs9KhmhfNKLRd+aoUi8mL9UWyvXjghA3ZyX
 K2Sk/pfPFWHCibXpZb5JMpee8qvYxPPYVkzIl1RQ9wBQZPUI958y2XWep0UhAsE/ShIZom4sn
 g5qMBxZ97JC4ExJ6yxv41rbIk8zRk5+I7VIu8cMFmsiRyT8rgU2FsuoNbPttTnyDPqlz9F1kL
 OyzrrzMcxz9ezL6t/47SSDBpafZMZq1SZagkLXRa+xfkg1CSzu8pprfnPiv7G7eZYqYlTQ4yM
 AJiBboDYbvfzZGx59CBaZlTVUflAT/hkeimwSeU6sPbk8LrNvdo4+3Hauv074AjLKtus5dWfc
 u5flI1D5LnB5STHkASTwuqvG40rP3xJmpGyUtWKH5Bzu8Y8ZgmcmALvaTm1+o0aJ7TMeOFOMk
 W7+FEs8NYC1KnPm7zYaMR90InWi6dw2Daw3WbgksrzmnFbWtWKUYbHLaYsfaVmQSEd70tTOcD
 3ZmGQPkL9Zkxy5JqS+I9HkRVqW2j6krsrh2kfGsV214fsSnVJvaZCz9Qo7NWwJChCehyMSfYi
 +F9y1ihc6OQmsqWfLxh9+xp2frYz8TkjRNrcnLasgRyoytBFbkklgNReerY3ZAm7nKQmafbP/
 V0Nn71aRiZxhFU9wJsqATryxzapO6K0hdojPCb7bzfizFi2bcsruho8HQ6LkoVZGeFqC97b5B
 WeFcfym6eQ8LEgIeyjDgLbDh6RCY8ue6s3M3t4gkjR05fvuziN99wQtLmV1MG4tcrFenpc6Hq
 HUk9H/RO8QwWUbuNuBZ0nGHpMVecyGhCV3xwrBjtpn721iO+oqSmj035F2eWDqO3/WEqzpw5e
 9ZQtbsi3J1ETLhKE4jF22Jp1q5EHc/UUJ03Xnb8a4X1LApcau0LF3vDHAgUEtducRLNoaqcBQ
 O0Z4HCO0Z3ZWRlzMGa/Jfc/kIZnSlcenhi3lMHIkV1nLvR4E6dDHYlgv7D+/eQHTzlpjtDaLi
 c/I6FGuM4meHrm3HWzfP7te8IhiqHZpDLd2Y1VLN+695XOvbh4ioUmSq+Z4HHfJtiKgRXzI1t
 hIvSwe7X2HTSGSA==
X-Rspamd-Queue-Id: BE0C855C52D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.us,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmx.us:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9587-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.us,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmx.us];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[len.bao@gmx.us,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmx.us:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.us:email,gmx.us:mid,gmx.us:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The 'migratable' variable is initialized only during the init phase
in the 'init_trusted' function and never changed. So, mark it as
__ro_after_init.

Signed-off-by: Len Bao <len.bao@gmx.us>
=2D--
 security/keys/trusted-keys/trusted_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/tru=
sted-keys/trusted_core.c
index 0b142d941..433579365 100644
=2D-- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -59,7 +59,7 @@ DEFINE_STATIC_CALL_NULL(trusted_key_unseal,
 DEFINE_STATIC_CALL_NULL(trusted_key_get_random,
 			*trusted_key_sources[0].ops->get_random);
 static void (*trusted_key_exit)(void);
-static unsigned char migratable;
+static unsigned char migratable __ro_after_init;
=20
 enum {
 	Opt_err,
=2D-=20
2.43.0


